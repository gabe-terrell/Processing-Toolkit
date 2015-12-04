interface Animation {
    // Calling this method will animate a single frame
    // It is designed to be called once every draw cycle
    void animateFrame();

    // Returns true if the animation is completed
    boolean isFinished();

    // Resets the animation to its initial state
    void resetAnimation();
}

abstract class FrameAnimation implements Animation {
    // Total number of frames in animation
    private int totalFrames;

    // Current frame the animation is on
    private int currentFrame;

    // Indicates if all frames have been animated
    private boolean finishedAnimation;

    // Initialize an animation with a total number of frames
    FrameAnimation (int numberOfFrames) {
        currentFrame = 0;
        totalFrames = numberOfFrames;
        finishedAnimation = (numberOfFrames == 0);
    }

    // Defaults to a one frame animation
    FrameAnimation() {
        this(1);
    }

    // Calling this method will animate a single frame
    // It is designed to be called once every draw cycle
    void animateFrame() {
        if (!finishedAnimation) {
            animateFrame(currentFrame);
            currentFrame++;
            if (currentFrame == totalFrames) {
                finishedAnimation = true;
            }
        }
    }

    abstract void animateFrame (int currentFrame);

    // Returns true if the animation is completed
    boolean isFinished() {
        return finishedAnimation;
    } 

    // Resets the animation to its initial state
    void resetAnimation() {
        currentFrame = 0;
        finishedAnimation = (totalFrames == 0);
    }
}

abstract class AnimationBatch implements Animation {
    // ArrayList of Animations that still need to be animated
    ArrayList<Animation> queuedAnimations;

    // ArrayList of Animations that have finished animating
    ArrayList<Animation> finishedAnimations;

    // An AnimationBatch can be initialized empty
    AnimationBatch () {
        queuedAnimations = new ArrayList<Animation>();
        finishedAnimations = new ArrayList<Animation>();
    }

    // Initialize an AnimaitonBatch with animations in the queue
    AnimationBatch (Animation[] animations) {
        this();
        addAnimations(animations);
    }

    // Adds a new animaiton to the end of the animation queue
    void addAnimation (Animation animation) {
        queuedAnimations.add(animation);
    }

    // Adds an array of animations to the end of the animation queue
    void addAnimations (Animation[] animations) {
        for (Animation animation : animations) {
            queuedAnimations.add(animation);
        }
    }

    // Calling this method will animate a single frame
    // It is designed to be called once every draw cycle
    abstract void animateFrame();

    // Returns true if the animation is completed
    boolean isFinished() {
        return queuedAnimations.isEmpty();
    }

    // Resets the animation to its initial state
    void resetAnimation() {
        ArrayList<Animation> allAnimations = new ArrayList<Animation>();

        for (Animation animation : finishedAnimations) {
            animation.resetAnimation();
            allAnimations.add(animation);
        }
        for (Animation animation : queuedAnimations) {
            animation.resetAnimation();
            allAnimations.add(animation);
        }

        queuedAnimations = allAnimations;
        finishedAnimations = new ArrayList<Animation>();
    }
}

class AnimationQueue extends AnimationBatch {
    // Animate the animation in the front of the queue and dequeue if finished
    void animateFrame() {
        if (!isFinished()) {
            Animation animation = queuedAnimations.get(0);
            animation.animateFrame();
            if (animation.isFinished()) {
                finishedAnimations.add(animation);
                queuedAnimations.remove(0);
            }
        }
    }
}

class AnimationGroup extends AnimationBatch {
    // Animate all animations in the queue and dequeue finished animations
    void animateFrame() {
        if (!isFinished()) {
            ArrayList<Animation> finishingAnimations = new ArrayList<Animation>();

            for (Animation animation : queuedAnimations) {
                animation.animateFrame();
                if (animation.isFinished()) {
                    finishingAnimations.add(animation);
                }
            }

            for (Animation animation : finishingAnimations) {
                finishedAnimations.add(animation);
                queuedAnimations.remove(animation);
            }
        }
    }
}