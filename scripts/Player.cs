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

        public override void _PhysicsProcess(double delta)
        {
            Vector2 inputVector = new Vector2(0, Input.GetAxis(PlayerInput.Forward, PlayerInput.Backward));
            Velocity += inputVector * acceleration;
            MoveAndSlide();
        }
    }

}
