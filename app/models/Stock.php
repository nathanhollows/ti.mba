<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Stock extends Model
{
    /**
     *
     * @var string
     */
    public $packetNo;

    /**
     *
     * @var boolean
     */
    public $current;

    /**
     * Set relationships for the model
     */
    public function initialize()
    {
        $this->hasMany('packetNo', 'App\Models\PacketTallies', 'packetNo', array('alias'  => 'tallies'));
        $this->hasOne('createdId', 'App\Models\PacketHistory', 'id', array('alias'  => 'created'));
        $this->hasOne('lastId', 'App\Models\PacketHistory', 'id', array('alias'  => 'lastRecord'));
        $this->hasMany('packetNo', 'App\Models\PacketHistory', 'packetNo', array('alias'  => 'history'));
    }

    /**
     * Get all current packets
     * @return App\Models\Stock
     */
    public function getCurrent()
    {
        return self::find([
            'conditions'    => 'current = 1'
        ]);
    }

    /**
     * checkStockFromRequest returns the amount of stock available for a given criteria
     * 
     * The request MUST contain either
     * - random (int) - the total lineal meters of stock required
     * OR
     * - length (float) - the length of stock required
     * - pieces (int) - the number of pieces required
     * 
     * The request may also contain
     * - width (int)
     * - thickness (int)
     * - grade (string)
     * - finish (string)
     * - treatment (string)
     * - dryness (string)
     * - current (bool, default true) - whether to check current stock or all stock
     * - offsite (bool, default false) - whether to check offsite stock or all stock
     * 
     * Returns an array with the following keys
     * - inStock (bool) - whether the stock is available
     * - count (float) - the total lineal meters of stock available, or the total number of pieces available
     * 
     * @param \Phalcon\Http\Request|\Phalcon\Http\RequestInterface $request
     * @return mixed Phalcon\Mvc\Model\Query\BuilderInterface
     */
    public function checkStockFromRequest($request)
    {
        $builder = $this->modelsManager->createBuilder()
            ->from(["s" => "App\Models\Stock"])
            ->join('App\Models\PacketHistory', 'lastId = h.id', 'h')
            ->join('App\Models\PacketTallies', 't.packetNo = s.packetNo', 't')
            ->where('s.packetNo NOT LIKE "%x"');

        if ($request->hasQuery('current')) {
            $builder->andWhere('s.current = :current:', ['current' => $request->getQuery('current')]);
        } else {
            $builder->andWhere('s.current = 1');
        }

        if ($request->hasQuery('random')) {
            $builder->setBindParams(['random' => $request->getQuery('random')]);
            $builder->columns('IF(sum(linealTally) > :random:, 1, 0) as inStock, sum(linealTally) as lineal');
        }

        if ($request->hasQuery('length')) {
            $builder->andWhere('t.length = :length:', ['length' => $request->getQuery('length')]);
            $builder->setBindParams(['pieces' => $request->getQuery('pieces')], true);
            $builder->columns('IF(sum(t.count) > :pieces:, 1, 0) as inStock, sum(t.count) as count');
        }

        if ($request->hasQuery('lm')) {
            $builder->andWhere('finishWidth = :width:', ['width' => $request->getQuery('width')]);
        }

        if ($request->hasQuery('width')) {
            $builder->andWhere('finishWidth = :width:', ['width' => $request->getQuery('width')]);
        }

        if ($request->hasQuery('thickness')) {
            $builder->andWhere('finishThickness = :thickness:', ['thickness' => $request->getQuery('thickness')]);
        }

        if ($request->hasQuery('grade')) {
            switch ($request->getQuery('grade')) {
                case 'RCM':
                    $builder->andWhere('grade = :grade: OR grade = "RC1" OR grade = "RC2"', ['grade' => $request->getQuery('grade')]);
                    break;
                case 'RSG8':
                    $builder->andWhere('grade = :grade: OR grade = "RWNO1" OR grade = "RGL8" OR grade = "RMSG8" or grade = "RVSG8"', ['grade' => $request->getQuery('grade')]);
                    break;
                case 'RTSG8':
                    $builder->andWhere('grade = :grade: OR grade = "RNO1" OR grade = "RTSG10"', ['grade' => $request->getQuery('grade')]);
                    break;
                case 'SPR8':
                    $builder->andWhere('grade = :grade: OR grade = "SPRUCE" OR grade = "SPR10"', ['grade' => $request->getQuery('grade')]);
                    break;
                default:
                    $builder->andWhere('grade = :grade:', ['grade' => $request->getQuery('grade')]);
                    break;
            }
        }

        if ($request->hasQuery('treatment')) {
            switch ($request->getQuery('treatment')) {
                case 'H4':
                    $builder->andWhere('treatment = :treatment: OR treatment = "H5"', ['treatment' => $request->getQuery('treatment')]);
                    break;
                default:
                    $builder->andWhere('treatment = :treatment:', ['treatment' => $request->getQuery('treatment')]);
            }
        }

        if ($request->hasQuery('dryness')) {
            $builder->andWhere('dryness = :dryness:', ['dryness' => $request->getQuery('dryness')]);
        }

        if ($request->hasQuery('finish')) {
            $builder->andWhere('finish = :finish:', ['finish' => $request->getQuery('finish')]);
        }

        if ($request->hasQuery('offsite')) {
            $builder->andWhere('offsite = :offsite:', ['offsite' => $request->getQuery('onsite')]);
        } else {
            $builder->andWhere('offsite = 0');
        }

        return $builder;
    }

    /**
     * searchStockFromRequest returns the stock available for a given criteria
     * 
     * The request may contain
     * - width (int)
     * - thickness (int)
     * - grade (string)
     * - finish (string)
     * - treatment (string)
     * - dryness (string)
     * - current (bool, default true) - whether to check current stock or all stock
     * - offsite (bool, default false) - whether to check offsite stock or all stock
     * 
     * Returns an object containing the stock available
     * 
     * @param \Phalcon\Http\Request|\Phalcon\Http\RequestInterface $request
     * @return mixed Phalcon\Mvc\Model\Query\BuilderInterface
     */
    public function searchStockFromRequest($request)
    {
        $builder = $this->modelsManager->createBuilder()
            ->columns('h.*')
            ->from(["s" => "App\Models\Stock"])
            ->join('App\Models\PacketHistory', 'lastId = h.id', 'h')
            ->where('s.packetNo NOT LIKE "%x"');

        if ($request->hasQuery('inStock')) {
            $builder->andWhere('s.current = :inStock:', ['inStock' => $request->getQuery('inStock')]);
        } else {
            $builder->andWhere('s.current = 1');
        }

        if ($request->hasQuery('width')) {
            $builder->andWhere('finishWidth = :width:', ['width' => $request->getQuery('width')]);
        }

        if ($request->hasQuery('thickness')) {
            $builder->andWhere('finishThickness = :thickness:', ['thickness' => $request->getQuery('thickness')]);
        }

        if ($request->hasQuery('grade')) {
            $builder->andWhere('grade = :grade:', ['grade' => $request->getQuery('grade')]);
        }

        if ($request->hasQuery('treatment')) {
            $builder->andWhere('treatment = :treatment:', ['treatment' => $request->getQuery('treatment')]);
        }

        if ($request->hasQuery('dryness')) {
            $builder->andWhere('dryness = :dryness:', ['dryness' => $request->getQuery('dryness')]);
        }

        if ($request->hasQuery('finish')) {
            $builder->andWhere('finish = :finish:', ['finish' => $request->getQuery('finish')]);
        }

        if ($request->hasQuery('offsite')) {
            $builder->andWhere('offsite = :offsite:', ['offsite' => $request->getQuery('onsite')]);
        }

        return $builder;
    }
}
