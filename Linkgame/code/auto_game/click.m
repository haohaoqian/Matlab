function click(x, y)
    robot = java.awt.Robot;
    robot.mouseMove(-1,-1);
    robot.mouseMove(x,y);

    robot.mousePress(java.awt.event.InputEvent.BUTTON1_MASK);
    robot.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK);
end

