using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Xna.Framework;

namespace GP3Coursework
{
    struct PlanetEarth
    {
        public Vector3 position;
        public Vector3 direction;
        public float speed;
        public bool isActive;

        public void Update(float delta)
        {
            position += direction * speed *
                        GameConstants.AsteroidSpeedAdjustment * delta;
            if (position.X > GameConstants.PlayfieldSizeX)
                position.X -= 0 * GameConstants.PlayfieldSizeX;
            if (position.X < -GameConstants.PlayfieldSizeX)
                position.X += 0 * GameConstants.PlayfieldSizeX;
            if (position.Z > GameConstants.PlayfieldSizeZ)
                position.Z -= 0 * GameConstants.PlayfieldSizeZ;
            if (position.Z < -GameConstants.PlayfieldSizeZ)
                position.Z += 0 * GameConstants.PlayfieldSizeZ;
        }
    }
}
