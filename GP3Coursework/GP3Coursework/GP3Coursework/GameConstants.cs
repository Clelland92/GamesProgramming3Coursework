using System;
using System.Collections.Generic;
using System.Text;

namespace GP3Coursework
{
    static class GameConstants
    {
        //camera constants
        public const float CameraHeight = 25000.0f;
        public const float PlayfieldSizeX = 100f;
        public const float PlayfieldSizeZ = 300f;
        //Asteroid constants
        public const int NumAsteroids = 10;
        public const float AsteroidMinSpeed = 3.0f;
        public const float AsteroidMaxSpeed = 10.0f;
        public const float AsteroidSpeedAdjustment = 2.5f;
        public const float AsteroidScalar = 0.01f;
        //Enemy Constraints 
        public const int NumEnemy = 5;
        public const float EnemyMinSpeed = 3.0f;
        public const float EnemyMaxSpeed = 10.0f;
        public const float EnemySpeedAdjustment = 2.5f;
        public const float EnemyScalar = 0.01f;
        //Planet constants
        public const int NumPlanetEarth = 1;

        public const int NumPlanetIce = 1; 
        //collision constants
        public const float AsteroidBoundingSphereScale = 0.025f;  //50% size
        public const float ShipBoundingSphereScale = 0.5f;  //50% size
        public const float LaserBoundingSphereScale = 0.85f;  //50% size
        public const float EnemyBoundingSphereScale = 0.5f;
        //bullet constants
        public const int NumLasers = 30;
        public const float LaserSpeedAdjustment = 5.0f;
        public const float LaserScalar = 3.0f;

    }
}
