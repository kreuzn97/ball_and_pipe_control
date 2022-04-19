# Ball and Pipe Control System Overview
With this project we are given a ping-pong ball, plastic tube and a serial port communication. Within the lab, you have to write and utilize code to get the ball to a specific position within the tube. You do this by changing the PWM of the system. Once it is at the position, you have to get the ball to hold that postition. At any moment you can read the sensors to see the position of ball. 

When writing the code, there are many methods that you can use to implement the system. This include, but are not limited to: PI controller, PID controller, Q-learning, Actor-Critic Method. For this project, our group decided to use the Actor-Critic Method. 

# Actor-Critic Method
To fully understand the Actor-Critic method, first, you have to understand what reinforment learning is. Reinforcement learning is a method that takes random samples to achieve success. Through the rewards that it gets, it tries to increase the probability for good actions and decrease the probability for bad actions. This is similar to playing a game with a controller with infinatly many buttons and not being told the rules. From there you play the game until you win.

Actor Critic is a branch of this, instead of one object recieving and changing, it splits up the tasks. The actor outputs the desired action in a continuous space. It takes the current enviorment and determins the best action. The critic takes in the action and enviroment to produce the rewards. This is similar to a kid playing on a playground. The kid playing and exploring is the actor and the parent watching is the critic

This is implemented through a setup, model and training program. The setup is where you define the constants and import the packages. The model is where you define all of the state dependent  values, everything changing and all the actions. This training program is where you run the agent within the enviroment. This is where it keeps track of the states and rewards. It is also the place where rewards are given. The training program computes the return at each step, the loss of both actor and critic, computes gradent and updates the parameters. 

# How to Use Code
For the code given, you link it to the tube serial port and run the program. It will automaticially enter training mode where it will try to move the ball to the set postition. After time, the ball should level out to the wanted postion. To change the height of the wanted position, edit the target parameter. 
