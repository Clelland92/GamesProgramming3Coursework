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

namespace Lab4CamerasV4
{
    /// <summary>
    /// This is the main type for your game
    /// </summary>
    public class Game1 : Microsoft.Xna.Framework.Game
    {
        GraphicsDeviceManager graphics;
        SpriteBatch spriteBatch;

        #region User Defined Variables

        private VertexDeclaration mVertexDeclaration;
        /// <summary>
        /// Declare vertex array to store the vertices containing position and colour info
        /// for the cube
        /// </summary>
        private VertexPositionTexture[] mVtCube = new VertexPositionTexture[24]; // canged from VertexPositionColor to VertexPositionTexture
        private VertexBuffer vertexBuffer;
        private short[] cubeIndices;
        private IndexBuffer indexBuffer;

        Texture2D textureMap; // added

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

        /// <summary>
        /// User defined function to define the position and colour of each vertex
        /// </summary>
        private void def_Cube()
        {
            Vector3 topLeftFront = new Vector3(-1.0f, 1.0f, 1.0f);
            Vector3 bottomLeftFront = new Vector3(-1.0f, -1.0f, 1.0f);
            Vector3 topRightFront = new Vector3(1.0f, 1.0f, 1.0f);
            Vector3 bottomRightFront = new Vector3(1.0f, -1.0f, 1.0f);
            Vector3 topLeftBack = new Vector3(-1.0f, 1.0f, -1.0f);
            Vector3 topRightBack = new Vector3(1.0f, 1.0f, -1.0f);
            Vector3 bottomLeftBack = new Vector3(-1.0f, -1.0f, -1.0f);
            Vector3 bottomRightBack = new Vector3(1.0f, -1.0f, -1.0f);

            mVtCube[0] = new VertexPositionTexture(topLeftFront, new Vector2(0.5f, 0.66f));
            mVtCube[1] = new VertexPositionTexture(bottomLeftFront, new Vector2(0.5f, 1.0f));
            mVtCube[2] = new VertexPositionTexture(topRightFront, new Vector2(1.0f, 0.66f));
            mVtCube[3] = new VertexPositionTexture(bottomRightFront, new Vector2(1.0f, 1.0f));

            mVtCube[4] = new VertexPositionTexture(topLeftBack, new Vector2(0.5f, 0.0f));
            mVtCube[5] = new VertexPositionTexture(topRightBack, new Vector2(0.0f, 0.0f));
            mVtCube[6] = new VertexPositionTexture(bottomLeftBack, new Vector2(0.5f, 0.33f));
            mVtCube[7] = new VertexPositionTexture(bottomRightBack, new Vector2(0.0f, 0.33f));

            mVtCube[8] = new VertexPositionTexture(topLeftFront, new Vector2(0.0f, 0.66f));
            mVtCube[9] = new VertexPositionTexture(topRightBack, new Vector2(0.5f, 0.33f));
            mVtCube[10] = new VertexPositionTexture(topLeftBack, new Vector2(0.0f, 0.33f));
            mVtCube[11] = new VertexPositionTexture(topRightFront, new Vector2(0.5f, 0.66f));

            mVtCube[12] = new VertexPositionTexture(bottomLeftFront, new Vector2(0.5f, 0.33f));
            mVtCube[13] = new VertexPositionTexture(bottomLeftBack, new Vector2(0.5f, 0.66f));
            mVtCube[14] = new VertexPositionTexture(bottomRightBack, new Vector2(1.0f, 0.66f));
            mVtCube[15] = new VertexPositionTexture(bottomRightFront, new Vector2(1.0f, 0.33f));

            mVtCube[16] = new VertexPositionTexture(topLeftFront, new Vector2(0.0f, 0.66f));
            mVtCube[17] = new VertexPositionTexture(bottomLeftBack, new Vector2(0.5f, 1.0f));
            mVtCube[18] = new VertexPositionTexture(bottomLeftFront, new Vector2(0.5f, 0.66f));
            mVtCube[19] = new VertexPositionTexture(topLeftBack, new Vector2(0.0f, 1.0f));

            mVtCube[20] = new VertexPositionTexture(topRightFront, new Vector2(0.5f, 0.0f));
            mVtCube[21] = new VertexPositionTexture(bottomRightFront, new Vector2(0.5f, 0.33f));
            mVtCube[22] = new VertexPositionTexture(bottomRightBack, new Vector2(1.0f, 0.33f));
            mVtCube[23] = new VertexPositionTexture(topRightBack, new Vector2(1.0f, 0.0f));

            cubeIndices = new short[] {  0,  1,  2,  // red front face
                                     1,  3,  2,
                                     4,  5,  6,  // orange back face
                                     6,  5,  7,
                                     8,  9, 10,  // yellow top face
                                     8, 11,  9,
                                    12, 13, 14,  // purple bottom face
                                    12, 14, 15,
                                    16, 17, 18,  // blue left face
                                    19, 17, 16,
                                    20, 21, 22,  // green right face
                                    23, 20, 22  };

            vertexBuffer = new VertexBuffer(graphics.GraphicsDevice,
                                            typeof(VertexPositionTexture),
                                            mVtCube.Length,
                                            BufferUsage.None);

            vertexBuffer.SetData<VertexPositionTexture>(mVtCube);

            indexBuffer = new IndexBuffer(graphics.GraphicsDevice,
                typeof(short),
                cubeIndices.Length,
                BufferUsage.None);

            indexBuffer.SetData<short>(cubeIndices);

        }

        private void InitializeTransform()
        {

            //---------------------------------------------------------------------------------------------------------------------------------------
            //Create initial camera view
            //---------------------------------------------------------------------------------------------------------------------------------------
            camPosition = new Vector3(0, 0, 10);
            camLookat = Vector3.Zero;
            camViewMatrix = Matrix.CreateLookAt(camPosition, camLookat, Vector3.Up);

            projectionMatrix = Matrix.CreatePerspectiveFieldOfView(
                MathHelper.ToRadians(45),
                (float)graphics.GraphicsDevice.Viewport.Width /
                (float)graphics.GraphicsDevice.Viewport.Height,
                1.0f, 1000.0f);

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


        private void InitializeEffect()
        {

            basicEffect = new BasicEffect(graphics.GraphicsDevice);
            basicEffect.View = camViewMatrix;
            basicEffect.Projection = projectionMatrix;
            basicEffect.World = worldMatrix;
            basicEffect.TextureEnabled = true; //added

        }

        //--------------------------------------------------
        // Update the position and direction of the camera.
        //--------------------------------------------------
        void RotateCamera()
        {
            KeyboardState keyboardState = Keyboard.GetState();
            if (keyboardState.IsKeyDown(Keys.Left))
            {
                // Rotate left.
                camYaw += camRotationSpeed;
            }
            if (keyboardState.IsKeyDown(Keys.Right))
            {
                // Rotate right.
                camYaw -= camRotationSpeed;
            }
        }

        //------------------------------------------------------------
        // Update the position and direction of the cube.
        //------------------------------------------------------------
        private void RotateCube()
        {
            KeyboardState keyboardState = Keyboard.GetState();

            Matrix rotationYMatrix;
            Matrix rotationXMatrix;

            if (keyboardState.IsKeyDown(Keys.Left))
            {
                // Rotate left.
                rotationYMatrix = Matrix.CreateRotationY(-(MathHelper.TwoPi / 360.0f));
                updateCubePos(rotationYMatrix);

            }
            if (keyboardState.IsKeyDown(Keys.Right))
            {
                // Rotate right.
                rotationYMatrix = Matrix.CreateRotationY((MathHelper.TwoPi / 360.0f));
                updateCubePos(rotationYMatrix);

            }
            if (keyboardState.IsKeyDown(Keys.Up))
            {
                // Rotate up.
                rotationXMatrix = Matrix.CreateRotationX(-(MathHelper.TwoPi / 360.0f));
                updateCubePos(rotationXMatrix);

            }
            if (keyboardState.IsKeyDown(Keys.Down))
            {
                // Rotate Down.
                rotationXMatrix = Matrix.CreateRotationX((MathHelper.TwoPi / 360.0f));
                updateCubePos(rotationXMatrix);
            }
        }

        /// <summary>
        /// Update each vertix of the triangle
        /// </summary>
        private void updateCubePos(Matrix rotationMatrix)
        {
            for (int i = 0; i < 24; i++)
            {
                mVtCube[i].Position = Vector3.Transform(mVtCube[i].Position, rotationMatrix);
            }
            vertexBuffer = new VertexBuffer(graphics.GraphicsDevice,
                                            typeof(VertexPositionTexture),
                                            mVtCube.Length,
                                            BufferUsage.None);

            vertexBuffer.SetData<VertexPositionTexture>(mVtCube);

            indexBuffer = new IndexBuffer(graphics.GraphicsDevice,
                typeof(short),
                cubeIndices.Length,
                BufferUsage.None);

            indexBuffer.SetData<short>(cubeIndices);
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
            mVertexDeclaration = new VertexDeclaration(VertexPositionTexture.VertexDeclaration.GetVertexElements());
            InitializeTransform();
            InitializeEffect();
            def_Cube(); // setup array
            Window.Title = "Lab 4 - Cameras";

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

            // TODO: use this.Content to load your game content here
            //-------------------------------------------------------------
            // added to load dice texture
            //-------------------------------------------------------------
            textureMap = Content.Load<Texture2D>(".\\Textures\\diceFaces");
            basicEffect.Texture = textureMap;

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
            //---------------------------------
            RotateCamera();
            camUpdate();
            //---------------------------------
            base.Update(gameTime);
        }

        /// <summary>
        /// This is called when the game should draw itself.
        /// </summary>
        /// <param name="gameTime">Provides a snapshot of timing values.</param>
        protected override void Draw(GameTime gameTime)
        {
            GraphicsDevice.Clear(Color.CornflowerBlue);

            // TODO: Add your drawing code here
            // The effect is a compiled effect created and compiled elsewhere
            // in the application.
            RasterizerState rs = new RasterizerState();
            rs.CullMode = CullMode.CullClockwiseFace;
            graphics.GraphicsDevice.RasterizerState = rs;


            graphics.GraphicsDevice.Indices = indexBuffer;

            graphics.GraphicsDevice.SetVertexBuffer(vertexBuffer);
            // The effect is a compiled effect created and compiled elsewhere
            // in the application.

            this.basicEffect.View = camViewMatrix;

            basicEffect.CurrentTechnique.Passes[0].Apply();
            foreach (EffectPass pass in basicEffect.CurrentTechnique.Passes)
            {
                pass.Apply();
                graphics.GraphicsDevice.DrawIndexedPrimitives(
                    PrimitiveType.TriangleList,
                    0,
                    0,
                    mVtCube.Length,
                    0,
                    12);

            }

            base.Draw(gameTime);
        }
    }
}