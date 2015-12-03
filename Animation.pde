interface Animation {
	// Calling this method will animate a single frame
	void animateFrame();

	// Returns true if the animation is completed
	boolean isFinished();

	// Resets the animation to its initial state
	void resetAnimation();
}

class FrameAnimation implements Animation {
	// Total number of frames in animation
	private final int totalFrames;

	// Current frame the animation is on
	private int currentFrame;

	// Indicates if all frames have been animated
	private boolean finishedAnimation;

	Animation (int numberOfFrames) {
		currentFrame = 0;
		totalFrames = numberOfFrames;
		finishedAnimation = (numberOfFrames == 0);
	}

	Animation() {
		this(1);
	}

	void animateFrame() {
		if (!finishedAnimation) {
			animateFrame(currentFrame);
			currentFrame++;
			if (currentFrame == totalFrames) {
				finishedAnimation = true;
			}
		}
	}

	boolean isFinished() {
		return finishedAnimation;
	} 

	void resetAnimation() {
		currentFrame = 0;
		finishedAnimation = (numberOfFrames == 0);
	}
}