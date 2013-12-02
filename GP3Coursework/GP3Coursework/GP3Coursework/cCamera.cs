using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Audio;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.GamerServices;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using Microsoft.Xna.Framework.Media;

namespace GP3Coursework
{
    public class cCamera
    {
            
            #region User Defined Variables

            // Matrix viewMatrix;
            Matrix projectionMatrix;
            Matrix worldMatrix;

            //--------------------------------------------------------------------------------------
            // Added for the creation of a camera
            //--------------------------------------------------------------------------------------
            Matrix camViewMatrix; //Cameras view
            Matrix camRotationMatrix; //Rotation Matrix for camera to reflect movement around Y Axis
            Vector3 camPosition; //Position of Camera in world
            Vector3 camLookat; //Where the camera is looking or pointing at
            Vector3 camTransform; //Used for repositioning the camer after it has been rotated
            float camRotationSpeed; //Defines the amount of rotation
            float camYaw; //Cumulative rotation on Y

            BasicEffect basicEffect;
            #endregion

            #region User Defined Methods

            private void InitializeTransform()
            {

                //---------------------------------------------------------------------------------------------------------------------------------------
                //Create initial camera view
                //---------------------------------------------------------------------------------------------------------------------------------------
                camPosition = new Vector3(0, 0, 10);
                camLookat = Vector3.Zero;
                camViewMatrix = Matrix.CreateLookAt(camPosition, camLookat, Vector3.Up);

                

                worldMatrix = Matrix.Identity;
                camRotationSpeed = 1f / 60f;
            }

            //----------------------------------------------------------------------------
            // Updates camera view
            //----------------------------------------------------------------------------
            private void camUpdate()
            {
                camRotationMatrix = Matrix.CreateRotationY(camYaw);
                camTransform = Vector3.Transform(Vector3.Forward, camRotationMatrix);
                camLookat = camPosition + camTransform;

                camViewMatrix = Matrix.CreateLookAt(camPosition, camLookat, Vector3.Down);
            }  
            #endregion
        }
    }
