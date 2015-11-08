<?php
namespace App\Models;

use Phalcon\Mvc\Model,
	Phalcon\Mvc\Model\Validator\Uniqueness;

class Users extends Model
{

	public $id;

	public $name;

	public $email;

	public $password;

	public $mustChangePassword;

	public $profilesId;

	public $banned;

	public $suspended;

	public $active;

	// Before we create a user we must assign a password

	public function beforeValidationOnCreate()
	{
		if (empty($this->password)) {

			// Generate a plain temporary password
			$tempPassword = preg_replace('/[^a-zA-Z0-9]/', '', base64_encode(openssl_random_pseudo_bytes(12)));

			// The user must change their password in first login
			$this->mustChangePassword = 'Y';

			// Use this password as default
			$this->password = $this->getDI()
				->getSecurity()
				->hash($tempPassword);
		} else {
			// The user must not change their password on first login
		}

		// The account must ne confirmed via email
		$this->active = 'N';

		// The account is not suspended by default
		$this->suspended = 'N';

		// The account is not banned by default
		$this->banned = 'N';
	}

	// Send a confirmation e-mail to the user if the account is not active
	public function afterSave()
	{
		if ($this->active == 'N') {

			$emailConfirmation = new emailConfirmation();

			$emailConfirmation->userId = $this->id;

			if ($emailConfirmation->save()) {
				$this->getDI()
					->getFlash()
					->notice('A confirmation email has been sent to ' . $this->email);
			}
		}
	}

	// Validate that email are unique across users

	public function validation()
	{
		$this->validate(new Uniqueness(array(
			'field'		=> 'email',
			'message'	=> 'This email address has already been registered'
		)));

		return $this->validationHasFailed() != true;
	}

    public function initialize()
    {
        $this->belongsTo('profilesId', __NAMESPACE__ . '\Profiles', 'id', array(
            'alias' => 'profile',
            'reusable' => true
        ));

        $this->hasMany('id', __NAMESPACE__ . '\SuccessLogins', 'usersId', array(
            'alias' => 'successLogins',
            'foreignKey' => array(
                'message' => 'User cannot be deleted because he/she has activity in the system'
            )
        ));

        $this->hasMany('id', __NAMESPACE__ . '\PasswordChanges', 'usersId', array(
            'alias' => 'passwordChanges',
            'foreignKey' => array(
                'message' => 'User cannot be deleted because he/she has activity in the system'
            )
        ));

        $this->hasMany('id', __NAMESPACE__ . '\ResetPasswords', 'usersId', array(
            'alias' => 'resetPasswords',
            'foreignKey' => array(
                'message' => 'User cannot be deleted because he/she has activity in the system'
            )
        ));
    }
}