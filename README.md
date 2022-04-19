# Ball and Pipe Control System Overview
With this project we are given a ping-pong ball, plastic tube and a serial port communication. Within the lab, you have to write and utilize code to get the ball to a specific position within the tube. You do this by changing the PWM of the system. Once it is at the position, you have to get the ball to hold that postition. At any moment you can read the sensors to see the position of ball. 

When writing the code, there are many methods that you can use to implement the system. This include, but are not limited to: PI controller, PID controller, Q-learning, Actor-Critic Method. For this project, our group decided to use the Actor-Critic Method. 

# Actor-Critic Method
Before going over any methodology, the first thing to do is understand some common terminology. There are four main terms that are commonly used when talking about the actor-critic method: agent, enviorment, state dependent value and reward. Agent is the code that changes throughout the training process. This include the parameters and variables. Enviorment is the place where the agent interacts with different situations. The different situations are the states that the ball is subjected to. State dependent value is the variable that changes based on the current state. Reward is the result of the action taken within the enviroment. This can be a positive or a negative number. 

To fully understand the Actor-Critic method, you have to understand what reinforment learning is because it is a branch of it. Reinforcement learning is a method that takes random samples to achieve success. Through the trials that it takes, rewards are given (both positive and negative). Due to this, it will try to increase the probability for good actions and decrease the probability for bad actions. It does this by taking actions that yeilded positive rewards more frequently. 

![image](https://user-images.githubusercontent.com/79153246/164027257-2a1ad870-4d2a-4c8a-8bbe-c8f4f1fcbcb9.png)

Sometimes it is easier to understand with an example. Reinforment learning is like playing a video game without any instructions. You have no idea what to do to succeed. In addition to that you have a controller with an infinate amount of buttons. This means that there are infinately many things that you can do. Through trial and error, you can learn what yeilds positive results. Eventually through playing, you will win the game. 

![image](https://user-images.githubusercontent.com/79153246/164030089-8922753e-e502-4f6f-8f54-829f992dd7f5.png)

As stated before, Actor-Critic is a branch of reinforment learning. It follows the same trial and error process, but with this method, there is a bit more guidence. With reinforment learning, there is only one object that is doing both the action and recieveing the reward, but with actor-critic method, it splits up the tasks with two objects (the actor and the critic). The actor outputs the desired action in a continuous space. It is doing the action within the enviroment, allowing there is be a reward. The critic on the otherhand, takes in the action and enviroment to produce the rewards. From these rewards, the actor changes his actions to improve the results.

![image](https://user-images.githubusercontent.com/79153246/164026973-641303ff-4de6-40c7-92bc-9200111ea5da.png)

Just like reinforment learning, we are going to compare it to a real life thing. It is similar to a kid playing on a playground. The kid playing and exploring is the actor and the parent watching is the critic. The kid is going to run around going to things like the slide and monkey bars. If the kid were to run up the slide instead of sliding down it then the parent would tell them not to do that. The kid then would respond with going down the slide. If he continues to go up the slide though, the parent would continue to repermand him until he follows the rules. 

![image](https://user-images.githubusercontent.com/79153246/164032180-6cb5d296-c8d9-4b15-b9e8-2117149b66cb.png)

This is implemented through a setup, model and training program. The setup is where you define the constants and import the packages. The model is where you define all of the state dependent  values, everything changing and all the actions. This training program is where you run the agent within the enviroment. This is where it keeps track of the states and rewards. It is also the place where rewards are given. The training program computes the return at each step, the loss of both actor and critic, computes gradent and updates the parameters. 

# How to Use Code
For the code given, you link it to the tube serial port and run the program. It will automaticially enter training mode where it will try to move the ball to the set postition. After time, the ball should level out to the wanted postion. To change the height of the wanted position, edit the target parameter. 
