using Godot;

namespace Game.Player
{
    static class PlayerInput
    {
        public const string Forward = "move_forward";
        public const string Backward = "move_backward";
        public const string RotateRight = "rotate_right";
        public const string RotateLeft = "rotate_left";
    }
    public partial class Player : CharacterBody2D
    {
        [Export]
        float acceleration = 10.0f;

        /// <summary>
        /// prevent the player from going outside of the viewport
        /// </summary>
        /// <param name="viewportSize">the viewport size</param>
        private void preventOutsideMovement(Vector2 viewportSize)
        {
            if (GlobalPosition.Y < 0)
            {
                // player is above the screen
                GlobalPosition = GlobalPosition with { Y = viewportSize.Y };
            }
            else if (GlobalPosition.Y > viewportSize.Y)
            {
                GlobalPosition = GlobalPosition with { Y = 0 };
            }
        }

        public override void _PhysicsProcess(double delta)
        {
            Vector2 inputVector = new Vector2(0, Input.GetAxis(PlayerInput.Forward, PlayerInput.Backward));
            Velocity += inputVector * acceleration;
            MoveAndSlide();

            Vector2 viewportSize = GetViewportRect().Size;
            preventOutsideMovement(viewportSize);
        }
    }

}
