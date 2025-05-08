 Studio Task

 App features:
 User can create todo with the help of his voice. User speaks in mic and voice convert to text with the help of speech_to_text package . Then its pass to Large Language Model its decide either user want to create todo or update previous todo or delete todo.

If user want to create todo, then it return title, description base on title if user donot speak in voice and date time.
Then its store firebase and also add to list . 

Voice Like : Create a task title ‘GYM’ at 4:30 PM on May 9th, 2025.

If user want to update todo, then it return title, and date time which he/she speaks in voice.

Voice Like : Update the task title GYM to 5:50 PM on May 15th.

if user want to delete, then it return title which user speaks in voice.

Voice Like : Delete the task title GYM

I have use Firebase as database for storing todos .


Step Up: Flutter Version  3.29.2

LLM:
I Have use Open Router Ai model.
Converting speech to text and then pass in LLM it decide what functionality need to perform on the base of user voice commmend . It helps to declined either user want to create,update or delete todo and its response to that.


State Management:
GetX for state management in my Flutter project due to its simplicity, performance, and minimal boilerplate. GetX making it easy to update the UI in response to data changes without the need for complex code structures. Its built-in dependency injection and route management also streamline app architecture, helping maintain cleaner and more scalable code. Overall, GetX offers a lightweight yet powerful solution that speeds up development while maintaining code readability and efficiency.


https://github.com/user-attachments/assets/21cdb68b-9a53-4e47-b663-63288f058ebf



 
 
