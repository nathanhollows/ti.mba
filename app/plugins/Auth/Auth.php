<?php
namespace App\Plugins\Auth;

use Phalcon\Di\Injectable;
use App\Models\Users;
use App\Models\RememberTokens;
use App\Models\SuccessLogins;
use App\Models\FailedLogins;

/**
 * App\Plugins\Auth\Auth
 * Manages Authentication/Identity Management in App
 */
class Auth extends Injectable
{

    /**
     * Checks the user credentials
     *
     * @param array $credentials
     * @return boolan
     */
    public function check($credentials)
    {

        // Check if the user exist
        $user = Users::findFirstByEmail($credentials['email']);
        if ($user == false) {
            throw new Exception('Wrong email/password combination');
        }

        // Check the password
        if (!$this->security->checkHash($credentials['password'], $user->password)) {
            throw new Exception('Wrong email/password combination');
        }

        // Check if the user was flagged
        $this->checkUserFlags($user);

        // Register the successful login
        $this->saveSuccessLogin($user);

        $this->createRememberEnviroment($user);

        $this->session->set('auth-identity', array(
            'id' => $user->id,
            'name' => $user->name,
            'changePassword' => $user->mustChangePassword,
            'dev' => $user->dev,
            'uca' => $user->useUCA,
        ));
    }

    /**
     * Creates the remember me environment settings the related cookies and generating tokens
     *
     * @param App\Models\Users $user
     */
    public function saveSuccessLogin($user)
    {
        $successLogin = new SuccessLogins();
        $successLogin->usersId = $user->id;
        $successLogin->ipAddress = $this->request->getClientAddress();
        $successLogin->userAgent = $this->request->getUserAgent();
        $successLogin->timestamp = date('Y-m-d H:i:s');
        if (!$successLogin->save()) {
            $messages = $successLogin->getMessages();
            throw new Exception($messages[0]);
        }
    }

    /**
     * Creates the remember me environment settings the related cookies and generating tokens
     *
     * @param App\Models\Users $user
     */
    public function createRememberEnviroment(Users $user)
    {
        $userAgent = $this->request->getUserAgent();
        $token = md5($user->email . $user->password . $userAgent);

        $remember = new RememberTokens();
        $remember->usersId = $user->id;
        $remember->token = $token;
        $remember->userAgent = $userAgent;

        if ($remember->save() != false) {
            $expire = time() + (7*24*60*60);
            $this->cookies->set('RMU', $user->id, $expire, '/', true, '', true);
            $this->cookies->set('RMT', $token, $expire, '/', true, '', true);
        }
    }

    /**
     * Check if the session has a remember me cookie
     *
     * @return boolean
     */
    public function hasRememberMe()
    {
        return $this->cookies->has('RMU');
    }

    /**
     * Logs on using the information in the coookies
     *
     * @return Phalcon\Http\Response
     */
    public function loginWithRememberMe($noRedirect = false)
    {
        $userId = $this->cookies->get('RMU')->getValue();
        $cookieToken = $this->cookies->get('RMT')->getValue();

        $user = Users::findFirstById($userId);
        if ($user) {
            $userAgent = $this->request->getUserAgent();
            $token = md5($user->email . $user->password . $userAgent);

            if ($cookieToken == $token) {
                $remember = RememberTokens::findFirst(array(
                    'usersId = ?0 AND token = ?1',
                                        'order' => 'id DESC',
                                        'limit' => '1',
                    'bind' => array(
                        $user->id,
                        $token
                    )
                ));
                if ($remember) {

                    // Check if the cookie has not expired
                    if ((time() - (86400 * 8)) < $remember->createdAt) {

                        // Check if the user was flagged
                        $this->checkUserFlags($user);

                        $this->session->set('auth-identity', array(
                                                    'id' => $user->id,
                                                    'name' => $user->name,
                                                    'changePassword' => $user->mustChangePassword,
                                                    'dev' => $user->dev,
                                                    'uca' => $user->useUCA,
                                                ));

                        // Register the successful login
                        $this->saveSuccessLogin($user);
                        if ($noRedirect) {
                            return false;
                        } else {
                            return $this->response->redirect("dashboard");
                        }
                    }
                }
            }
        }

        $this->cookies->get('RMU')->delete();
        $this->cookies->get('RMT')->delete();

        return $this->response->redirect('login');
    }

    /**
     * Checks if the user is suspended
     *
     * @param App\Models\Users $user
     */
    public function checkUserFlags(Users $user)
    {
        if ($user->suspended != '0') {
            throw new Exception('This account is suspended');
        }
    }

    /**
     * Returns the current identity
     *
     * @return array
     */
    public function getIdentity()
    {
        return $this->session->get('auth-identity');
    }

    /**
     * Returns if the user is currently logged in
     *
     * @return boolean
     */
    public function isLoggedIn()
    {
        return $this->session->has('auth-identity');
    }

    /**
     * Returns the current users id
     *
     * @return string
     */
    public function getId()
    {
        $identity = $this->session->get('auth-identity');
        return $identity['id'];
    }

    /**
     * Returns the current identity
     *
     * @return string
     */
    public function getName()
    {
        $identity = $this->session->get('auth-identity');
        return $identity['name'];
    }

    /**
     * Removes the user identity information from session
     */
    public function remove()
    {
        try {
            $this->cookies->get('RMU')->delete();
            $this->cookies->get('RMT')->delete();
        } catch (Exception $e) {
        }

        $this->session->remove('auth-identity');
    }

    /**
     * Auths the user by his/her id
     *
     * @param int $id
     */
    public function authUserById($id)
    {
        $user = Users::findFirstById($id);
        if ($user == false) {
            throw new Exception('The user does not exist');
        }

        $this->checkUserFlags($user);

        $this->session->set('auth-identity', array(
            'id' => $user->id,
            'name' => $user->name,
            'profile' => $user->profile->name
        ));
    }

    /**
     * Get the entity related to user in the active identity
     *
     * @return \App\Models\Users
     */
    public function getUser()
    {
        $identity = $this->session->get('auth-identity');
        if (isset($identity['id'])) {
            $user = Users::findFirstById($identity['id']);
            if ($user == false) {
                throw new Exception('The user does not exist');
            }

            return $user;
        }

        return false;
    }
}
