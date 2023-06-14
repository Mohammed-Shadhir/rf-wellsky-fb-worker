"""
    App.py : contains methods to start the program
"""
import robot
import robot.libraries


def invoke_fb_worker():
    run_result = robot.run("./robots/tasks.robot")
    print('\n\n', run_result)
    return run_result


if __name__ == "__main__":
    run_result = invoke_fb_worker()
