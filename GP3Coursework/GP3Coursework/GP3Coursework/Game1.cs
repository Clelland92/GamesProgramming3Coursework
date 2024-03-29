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
    /// <summary>
    /// This is the main type for your game
    /// </summary>
    public class Game1 : Microsoft.Xna.Framework.Game
    {
        GraphicsDeviceManager graphics;
        SpriteBatch spriteBatch;

        #region User Defined Variables
        //------------------------------------------
        // Added for use with fonts
        //------------------------------------------
        ////SpriteFont fontToUse;
        //--------------------------------------------------
        // Added for use with playing Audio via Media player
        //--------------------------------------------------
        private Song bkgMusic;
        private String songInfo;
        //--------------------------------------------------
        //Set the sound effects to use
        //--------------------------------------------------
        private SoundEffectInstance starShipSoundInstance;
        private SoundEffect starShipSound;
        private SoundEffect explosionSound;
        private SoundEffect firingSound;

        // Set the 3D model to draw.
        private Model mdlStarShip;
        private Matrix[] mdlStarShipTransforms;

        // The aspect ratio determines how to scale 3d to 2d projection.
        private float aspectRatio;

        // Set the position of the model in world space, and set the rotation.
        private Vector3 mdlPosition = Vector3.Zero;
        private float mdlRotation = 30.0f;
        private Vector3 mdlVelocity = Vector3.Zero; 

        // create an array of enemy daleks
        private Model mdlAsteroid;
        private Matrix[] mdlAsteroidTransforms;
        private Asteroid[] AsteroidList = new Asteroid[GameConstants.NumAsteroids];

        // create an array of laser bullets
        private Model mdlLaser;
        private Matrix[] mdlLaserTransforms;
        private Laser[] laserList = new Laser[GameConstants.NumLasers];

        // Create planets
        private Model mdlPlanetEarth;
        private Matrix[] mdlPlanetEarthTransforms;
        private Vector3 mdlEarthPos = new Vector3(200, 0, 0);

        // Create Satellite 
        private Model mdlSatellite;
        private Matrix[] mdlSatelliteTransfroms;
        private Vector3 mdlSatellitePos = new Vector3(-200, 3, 0);
        
        // Create an array enemy fighters  
        private Model mdlEnemy;
        private Matrix[] mdlEnemyTransforms;
        private Enemy[] EnemyList = new Enemy[GameConstants.NumEnemy];

        private bool soundPlayer = true;

        private Random random = new Random();

        private KeyboardState lastState;
        private int hitCount;

        private cCamera cam = new cCamera();
        // Set the position of the camera in world space, for our view matrix.
       // private Vector3 cameraPosition = new Vector3(0.0f, 3.0f, 300.0f);
       // private Matrix viewMatrix;
        //private Matrix projectionMatrix;

        private void InitializeTransform()
        {
            aspectRatio = graphics.GraphicsDevice.Viewport.AspectRatio;

          //  viewMatrix = Matrix.CreateLookAt(cameraPosition, Vector3.Zero, Vector3.Up);

            //projectionMatrix = Matrix.CreatePerspectiveFieldOfView(
              //  MathHelper.ToRadians(90), aspectRatio, 1.0f, 350.0f);

        }

        private void MoveModel()
        {
            KeyboardState keyboardState = Keyboard.GetState();
            GamePadState gamePadState = GamePad.GetState(PlayerIndex.One);

            // Create some velocity if the right trigger is down.
            Vector3 mdlVelocityAdd = Vector3.Zero;

            // Find out what direction we should be thrusting, using rotation.
           mdlVelocityAdd.X = -(float)Math.Sin(mdlRotation);
           mdlVelocityAdd.Z = -(float)Math.Cos(mdlRotation);
 
            if (keyboardState.IsKeyDown(Keys.Left) || gamePadState.DPad.Left == ButtonState.Pressed)
            {
                // Rotate left.
                mdlRotation -= -1.0f * 0.10f;
            }

            if (keyboardState.IsKeyDown(Keys.Right) || gamePadState.DPad.Right == ButtonState.Pressed)
            {
                // Rotate right.
                mdlRotation -= 1.0f * 0.10f;
            }

            if (keyboardState.IsKeyDown(Keys.Up) || gamePadState.DPad.Up == ButtonState.Pressed)
            {
                // Rotate left.
                // Create some velocity if the right trigger is down.
                // Now scale our direction by how hard the trigger is down.
                mdlVelocityAdd *= 0.05f;
                mdlVelocity += mdlVelocityAdd;
            }

            if (keyboardState.IsKeyDown(Keys.Down) || gamePadState.DPad.Down == ButtonState.Pressed)
            {
                // Rotate left.
                // Now scale our direction by how hard the trigger is down.
                mdlVelocityAdd *= -0.05f;
                mdlVelocity += mdlVelocityAdd;
            }

            // Resets the game to initial setup when the R key is pressed
            if (keyboardState.IsKeyDown(Keys.R) || gamePadState.Buttons.Start == ButtonState.Pressed) 
            {
                mdlVelocity = Vector3.Zero;
                mdlPosition = Vector3.Zero;
                mdlRotation = 0.0f;
                starShipSoundInstance.Play();
            }

            // Mutes the background Music
            if (keyboardState.IsKeyDown(Keys.M) || gamePadState.Buttons.RightShoulder == ButtonState.Pressed && soundPlayer == true)
            {
                soundPlayer = false;
            }

            // Unmutes the background Music
            if (keyboardState.IsKeyDown(Keys.N) || gamePadState.Buttons.LeftShoulder == ButtonState.Pressed && soundPlayer == false)
            {
                soundPlayer = true;
            }

            // Mutes all other sound effects 
            if (keyboardState.IsKeyDown(Keys.M) || gamePadState.Buttons.RightShoulder == ButtonState.Pressed)
            {
                SoundEffect.MasterVolume = 0;
            }

            // Unmutes all other sound effects 
            if (keyboardState.IsKeyDown(Keys.N) || gamePadState.Buttons.LeftShoulder == ButtonState.Pressed )
            {
                SoundEffect.MasterVolume = 1;
            }

            if (keyboardState.IsKeyDown(Keys.C) && lastState.IsKeyUp(Keys.C))
            {
                cam.SwitchCameraMode();
            }

            // Check to see if the player is shooting
            if (keyboardState.IsKeyDown(Keys.Space) || lastState.IsKeyDown(Keys.Space))
            {
                //add another bullet.  Find an inactive bullet slot and use it
                //if all bullets slots are used, ignore the user input
                for (int i = 0; i < GameConstants.NumLasers; i++)
                {
                    if (!laserList[i].isActive)
                    {
                        Matrix starshipTransform = Matrix.CreateRotationY(mdlRotation);
                        laserList[i].direction = starshipTransform.Forward;
                        laserList[i].speed = GameConstants.LaserSpeedAdjustment;
                        laserList[i].position = mdlPosition + laserList[i].direction;
                        laserList[i].isActive = true;
                        firingSound.Play();
                        break; //exit the loop     
                    }
                }
            }
            lastState = keyboardState;
        }

        private void ResetAsteroids()
        {
            float xStart;
            float zStart;
            for (int i = 0; i < GameConstants.NumAsteroids; i++)
            {
                if (random.Next(2) == 0)
                {
                    xStart = (float)-GameConstants.PlayfieldSizeX;
                }
                else
                {
                    xStart = (float)GameConstants.PlayfieldSizeX;
                }
                zStart = (float)random.NextDouble() * GameConstants.PlayfieldSizeZ;
                AsteroidList[i].position = new Vector3(xStart, 0.0f, zStart);
                double angle = random.NextDouble() * 2 * Math.PI;
                AsteroidList[i].direction.X = -(float)Math.Sin(angle);
                AsteroidList[i].direction.Z = (float)Math.Cos(angle);
                AsteroidList[i].speed = GameConstants.AsteroidMinSpeed +
                   (float)random.NextDouble() * GameConstants.AsteroidMaxSpeed;
                AsteroidList[i].isActive = true;
            }
        }

            private void ResetEnemy()
            {
            float xStart;
            float zStart;
            for (int i = 0; i < GameConstants.NumEnemy; i++)
            {
                if (random.Next(2) == 0)
                {
                    xStart = (float)-GameConstants.PlayfieldSizeX;
                }
                else
                {
                    xStart = (float)GameConstants.PlayfieldSizeX;
                }
                zStart = (float)random.NextDouble() * GameConstants.PlayfieldSizeZ;
                EnemyList[i].position = new Vector3(xStart, 0.0f, zStart);
                double angle = random.NextDouble() * 2 * Math.PI;
                EnemyList[i].direction.X = -(float)Math.Sin(angle);
                EnemyList[i].direction.Z = (float)Math.Cos(angle);
                EnemyList[i].speed = GameConstants.EnemyMinSpeed +
                   (float)random.NextDouble() * GameConstants.EnemyMaxSpeed;
                EnemyList[i].isActive = true;
            }
        }

        private Matrix[] SetupEffectTransformDefaults(Model myModel)
        {
            Matrix[] absoluteTransforms = new Matrix[myModel.Bones.Count];
            myModel.CopyAbsoluteBoneTransformsTo(absoluteTransforms);

            foreach (ModelMesh mesh in myModel.Meshes)
            {
                foreach (BasicEffect effect in mesh.Effects)
                {
                    effect.EnableDefaultLighting();
                    //effect.Projection = projectionMatrix;
                   // effect.View = viewMatrix;
                }
            }
            return absoluteTransforms;
        }

        public void DrawModel(Model model, Matrix modelTransform, Matrix[] absoluteBoneTransforms)
        {
            //Draw the model, a model can have multiple meshes, so loop
            foreach (ModelMesh mesh in model.Meshes)
            {
                //This is where the mesh orientation is set
                foreach (BasicEffect effect in mesh.Effects)
                {
                    effect.World = absoluteBoneTransforms[mesh.ParentBone.Index] * modelTransform;
                    effect.View = cam.viewMatrix;
                    effect.Projection = cam.projectionMatrix;
                }
                //Draw the mesh, will use the effects set above.
                mesh.Draw();
            }
        }

        private void writeText(string msg, Vector2 msgPos, Color msgColour)
        {
            spriteBatch.Begin();  
            //string output = msg;
            // Find the center of the string
            ////Vector2 FontOrigin = fontToUse.MeasureString(output) / 2;
            ////Vector2 FontPos = msgPos;
            // Draw the string
            //spriteBatch.DrawString(fontToUse, "hello", new Vector2(100, 100), Color.Yellow);
            spriteBatch.End();
            // This code gives the models solidity so they don't look transparent 
            GraphicsDevice.DepthStencilState = DepthStencilState.Default;
            GraphicsDevice.BlendState = BlendState.Opaque;
            GraphicsDevice.RasterizerState = RasterizerState.CullCounterClockwise;
            GraphicsDevice.SamplerStates[0] = SamplerState.LinearWrap;
        }

        #endregion

        public Game1()
        {
            graphics = new GraphicsDeviceManager(this);
            Content.RootDirectory = "Content";
            this.IsMouseVisible = true;
        }

        /// <summary>
        /// Allows the game to perform any initialization it needs to before starting to run.
        /// This is where it can query for any required services and load any non-graphic
        /// related content.  Calling base.Initialize will enumerate through any components
        /// and initialize them as well.
        /// </summary>
        protected override void Initialize()
        {
            // TODO: Add your initialization logic here
            this.IsMouseVisible = true;
            Window.Title = "GP3 Coursework";
            hitCount = 0;
            InitializeTransform();
            ResetAsteroids();
            ResetEnemy();

            base.Initialize();
        }

        /// <summary>
        /// LoadContent will be called once per game and is the place to load
        /// all of your content.
        /// </summary>
        protected override void LoadContent()
        {
            // Create a new SpriteBatch, which can be used to draw textures.
            spriteBatch = new SpriteBatch(GraphicsDevice);
            aspectRatio = graphics.GraphicsDevice.Viewport.AspectRatio;
            //------------------------------------------------------------- 
            // added to load font
            //-------------------------------------------------------------
            ////fontToUse = Content.Load<SpriteFont>(".\\Fonts\\DrWho");
            //-------------------------------------------------------------
            // added to load Song   
            //-------------------------------------------------------------
            bkgMusic = Content.Load<Song>(".\\Audio\\Imperial March");
            MediaPlayer.Play(bkgMusic);
            MediaPlayer.IsRepeating = true;
            songInfo = "Song: " + bkgMusic.Name + " Song Duration: " + bkgMusic.Duration.Minutes + ":" + bkgMusic.Duration.Seconds;
            //-------------------------------------------------------------
            // added to load Model
            //-------------------------------------------------------------
            mdlStarShip = Content.Load<Model>(".\\Models\\PlayerModel\\fighter");
            mdlStarShipTransforms = SetupEffectTransformDefaults(mdlStarShip);
            mdlAsteroid = Content.Load<Model>(".\\Models\\Environment\\Asteroid\\asteroid");
            mdlAsteroidTransforms = SetupEffectTransformDefaults(mdlAsteroid);
            mdlLaser = Content.Load<Model>(".\\Models\\Laser\\laser");
            mdlLaserTransforms = SetupEffectTransformDefaults(mdlLaser);
            mdlPlanetEarth = Content.Load<Model>(".\\Models\\Environment\\Planets\\planet_earth");
            mdlPlanetEarthTransforms = SetupEffectTransformDefaults(mdlPlanetEarth);
            mdlEnemy = Content.Load<Model>(".\\Models\\Enemy\\spaceship01");
            mdlEnemyTransforms = SetupEffectTransformDefaults(mdlEnemy);
            mdlSatellite = Content.Load<Model>(".\\Models\\Environment\\Satellite\\satellite");
            mdlSatelliteTransfroms = SetupEffectTransformDefaults(mdlSatellite);
            //-------------------------------------------------------------
            // added to load SoundFX's
            //-------------------------------------------------------------
            starShipSound = Content.Load<SoundEffect>("Audio\\tardisEdit");
            explosionSound = Content.Load<SoundEffect>("Audio\\explosion2");
            firingSound = Content.Load<SoundEffect>("Audio\\shot007");
            starShipSoundInstance = starShipSound.CreateInstance(); 
            starShipSoundInstance.Play();

             // TODO: use this.Content to load your game content here
        }

        /// <summary>
        /// UnloadContent will be called once per game and is the place to unload
        /// all content.
        /// </summary>
        protected override void UnloadContent()
        {
            // TODO: Unload any non ContentManager content here
        }

        /// <summary>
        /// Allows the game to run logic such as updating the world,
        /// checking for collisions, gathering input, and playing audio.
        /// </summary>
        /// <param name="gameTime">Provides a snapshot of timing values.</param>
        protected override void Update(GameTime gameTime)
        {
            // Allows the game to exit
            if (GamePad.GetState(PlayerIndex.One).Buttons.Back == ButtonState.Pressed)
                this.Exit();

            // TODO: Add your update logic here
            MoveModel();

            // Add velocity to the current position.
            mdlPosition += mdlVelocity;

            // Bleed off velocity over time.
            mdlVelocity *= 0.95f;

            float timeDelta = (float)gameTime.ElapsedGameTime.TotalSeconds;

            //Matrix modelTransform = Matrix.CreateRotationY(mdlRotation) * Matrix.CreateTranslation(mdlPosition);
            //updateCamera(modelTransform);
            // Camera update 
            Matrix modelTransform = Matrix.CreateRotationY(mdlRotation) * Matrix.CreateTranslation(mdlPosition);
            cam.Update(modelTransform);

            // checks to see if sound has been muted 
            if(soundPlayer == true)
            {
                MediaPlayer.Resume();
            }
            else if (soundPlayer == false)
            {
                MediaPlayer.Pause();
            }

            // Gets position of each asteroid in the game 
            for (int i = 0; i < GameConstants.NumAsteroids; i++)
            {
                AsteroidList[i].Update(timeDelta);
            }

            // Gets the position of each laser in game 
            for (int i = 0; i < GameConstants.NumLasers; i++)
            {
                if (laserList[i].isActive)
                {
                    laserList[i].Update(timeDelta);
                }
            }

            // Gets the position of each enemy in the game
            for (int i = 0; i < GameConstants.NumEnemy; i++)
            {
                if (EnemyList[i].isActive)
                {
                    EnemyList[i].Update(timeDelta);
                }
            }

            BoundingSphere StarShipSphere = new BoundingSphere(mdlPosition, mdlStarShip.Meshes[0].BoundingSphere.Radius * GameConstants.ShipBoundingSphereScale);

            //Check for collisions  
            for (int i = 0; i < AsteroidList.Length; i++)
            {
                if (AsteroidList[i].isActive)  
                {
                    BoundingSphere AsteroidSphereA =
                      new BoundingSphere(AsteroidList[i].position, mdlAsteroid.Meshes[0].BoundingSphere.Radius *
                                     GameConstants.AsteroidBoundingSphereScale);

                    for (int k = 0; k < laserList.Length; k++)
                    {
                        if (laserList[k].isActive)
                        {
                            BoundingSphere laserSphere = new BoundingSphere(
                              laserList[k].position, mdlLaser.Meshes[0].BoundingSphere.Radius *
                                     GameConstants.LaserBoundingSphereScale);
                            if (AsteroidSphereA.Intersects(laserSphere))
                            {
                                explosionSound.Play();
                                AsteroidList[i].isActive = false;
                                laserList[k].isActive = false;
                                hitCount++;
                                break; //no need to check other bullets
                            }
                        }
                        if (AsteroidSphereA.Intersects(StarShipSphere)) //Check collision between asteroid and Starship 
                        {
                            explosionSound.Play();
                            AsteroidList[i].direction *= -1.0f;
                            //laserList[k].isActive = false;
                            break; //no need to check other bullets
                        }
                    }

                    //Check for collisions  
                    for (int j = 0; j < EnemyList.Length; j++)
                    {
                        if (EnemyList[j].isActive)
                        {
                            BoundingSphere EnemySphereA =
                              new BoundingSphere(EnemyList[j].position, mdlEnemy.Meshes[0].BoundingSphere.Radius *
                                             GameConstants.EnemyBoundingSphereScale);

                            for (int k = 0; k < laserList.Length; k++)
                            {
                                if (laserList[k].isActive)
                                {
                                    BoundingSphere laserSphere = new BoundingSphere(
                                      laserList[k].position, mdlLaser.Meshes[0].BoundingSphere.Radius *
                                             GameConstants.EnemyBoundingSphereScale);
                                    if (EnemySphereA.Intersects(laserSphere))
                                    {
                                        explosionSound.Play();
                                        EnemyList[j].isActive = false;
                                        laserList[k].isActive = false;
                                        hitCount++;
                                        break; //no need to check other bullets
                                    }
                                }
                                if (EnemySphereA.Intersects(StarShipSphere)) //Check collision between enemy and Starship 
                                {
                                    explosionSound.Play();
                                    EnemyList[j].direction *= -1.0f;
                                    //laserList[k].isActive = false;
                                    break; //no need to check other bullets
                                }
                            }
                        }
                    }
                    base.Update(gameTime);
                }
            }
        }

        /// <summary>
        /// This is called when the game should draw itself.
        /// </summary>
        /// <param name="gameTime">Provides a snapshot of timing values.</param>
        protected override void Draw(GameTime gameTime)
        {
            GraphicsDevice.Clear(Color.CornflowerBlue);

            // Draws the asteroids according the number of asteroids in the list given
            for (int i = 0; i < GameConstants.NumAsteroids; i++)
            {
                if (AsteroidList[i].isActive)
                {
                    Matrix AsteroidTransform = Matrix.CreateScale(GameConstants.AsteroidScalar) * Matrix.CreateTranslation(AsteroidList[i].position);
                    DrawModel(mdlAsteroid, AsteroidTransform, mdlAsteroidTransforms);
                }
            }
            // Draws the number of lasers according the button press 
            for (int i = 0; i < GameConstants.NumLasers; i++)
            {
                if (laserList[i].isActive)
                {
                    Matrix laserTransform = Matrix.CreateScale(GameConstants.LaserScalar) * Matrix.CreateTranslation(laserList[i].position);
                    DrawModel(mdlLaser, laserTransform, mdlLaserTransforms);
                }
            }
            // Draws the number of enemies according to the number given in the enemy list  
            for (int i = 0; i < GameConstants.NumEnemy; i++)
            {
                if (EnemyList[i].isActive)
                {
                    Matrix enemyTransform = Matrix.CreateScale(GameConstants.LaserScalar) * Matrix.CreateTranslation(EnemyList[i].position);
                    DrawModel(mdlEnemy, enemyTransform, mdlEnemyTransforms);
                }
            }

            Matrix modelEarthTransform = Matrix.CreateRotationY(mdlRotation) * Matrix.CreateTranslation(mdlEarthPos);
            DrawModel(mdlPlanetEarth, modelEarthTransform, mdlPlanetEarthTransforms);

            Matrix modelSatelliteTransform = Matrix.CreateRotationY(mdlRotation) * Matrix.CreateTranslation(mdlSatellitePos);
            DrawModel(mdlSatellite, modelSatelliteTransform, mdlSatelliteTransfroms);

            Matrix modelTransform = Matrix.CreateRotationY(mdlRotation) * Matrix.CreateTranslation(mdlPosition);
            DrawModel(mdlStarShip, modelTransform, mdlStarShipTransforms);

            writeText("SPACE EXPLORER", new Vector2(50, 10), Color.Yellow);
            writeText("Instructions\nPress The Arrow keys to move the Tardis\nSpacebar to fire!\nR to Reset", new Vector2(50, 50), Color.Black);

            writeText(songInfo, new Vector2(50, 125), Color.AntiqueWhite);

            base.Draw(gameTime);
        }
    }
}
