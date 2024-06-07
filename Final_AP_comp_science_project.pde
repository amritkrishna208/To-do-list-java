ArrayList<Task> tasks;
String inputText = "";
boolean typing = false;

void setup() {
  size(1000, 800);
  tasks = new ArrayList<Task>();
}

void draw() {
  background(30); // Dark blue background
  displayTasks();
  if (typing) {
    drawInputBox();
  }
}

void displayTasks() {
  fill(255); // White text color
  textSize(36);
  textAlign(CENTER, TOP);
  text("Today's To-Do List", width/2, 20); // Title
  
  fill(200); // Gray text color
  textSize(24);
  textAlign(LEFT, TOP);
  int y = 80;
  int taskNumber = 1;
  for (Task task : tasks) {
    task.display(y, taskNumber); // Display tasks
    y += 40;
    taskNumber++;
  }
}

void drawInputBox() {
  fill(255); 
  rect(20, height - 70, width - 40, 30); 
  fill(0);
  textAlign(LEFT, CENTER);
  textSize(20);
  text(inputText, 25, height - 55); // Display input text
}

void keyPressed() {
  if (typing) {
    if (keyCode == BACKSPACE) {
      if (inputText.length() > 0) {
        inputText = inputText.substring(0, inputText.length() - 1);
      }
    } else if (keyCode == ENTER && inputText.length() > 0) {
      addTask(inputText);
      inputText = "";
      typing = false;
    } else if (keyCode != SHIFT && key != CODED) {
      inputText += key;
      
   
      boolean taskExists = false;
      for (Task task : tasks) {
        if (task.title.equals(inputText)) {
          task.completed = true; 
          taskExists = true;
          break; }
      }
      
      if (!taskExists) {
        typing = false; 
      }
    }
  }
}

void mousePressed() {
  if (mouseY > height - 70) {
    typing = true; 
  } else {
    typing = false;
  }
}

void addTask(String taskTitle) {
  tasks.add(new Task(taskTitle));
}

class Task {
  String title;
  boolean completed;
  float x, y, w, h;
  
  Task(String title) {
    this.title = title;
    this.completed = false;
    this.w = textWidth("- " + title);
    this.h = 24;
  }
  
  void setPosition(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void display(float posY, int taskNumber) {
    if (completed) {
      fill(0, 255, 0);
      stroke(0, 255, 0);
      line(20, posY + 12, 40 + w, posY + 12); // Strike-through line
    } else {
      fill(200); // Gray color 
    }
    text(taskNumber + ". " + title, 40, posY); // Display task
  }
}
