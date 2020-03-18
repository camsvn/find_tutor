import 'dart:io';

var mentorlist = new List();
var learnerlist= new List();

class Participant{
  String name;
  bool isMentor;
  String stack;
  String _time;

  Participant(String name){
    this.name=name;
    this.workflow();
  }

  void workflow (){
    _setMentorOrLearner();
    
    if(isMentor){
      _setAvailableTime();
      _addStack();
      mentorlist.add(this);
    }
    else{
      _addStack();
      learnerlist.add(this);
    }
    showDetails();
    pauseExecution(1000);
  }

  void showDetails(){
    var ptype = isMentor ? 'Mentor' : 'Learner';
    print('\n'+'⁛'*16+'Participant Details'+'⁛'*16);
    print('Name: $name');
    print('Participant Type: $ptype');
    isMentor ? (){print('Stack Expertise: $stack');} (): (){print('Stack Interest: $stack');} ();
    isMentor ? (){print('Availability: $_time');} (): {};
    print('⁛'*51);
  }

  void _addStack(){
    var type = isMentor ? 'expertise' : 'interest';

    print('\nWhat is your stack '+ type + '?');
    pauseExecution(500);
    print('Stack Examples: Django, MERN, LAMP, XAMP, Flask, MEAN ... ');
    pauseExecution(250);
    print('PS: Choose only one');
    stack=stdin.readLineSync();

  }

  void _setMentorOrLearner(){
    print('\n'+'+'*50);
    print(name +
      ''', Choose your category:
      \t1.Mentor\t2.Learner'''
      );
    print('+'*50 + '\n');

    String number = stdin.readLineSync();

    switch(number){
      case '1':
        isMentor=true;
        break;
      case '2':
        isMentor=false;
        break;
      default:
        pauseExecution(750);
        print('\n'+'※'*19+' Wrong Input!'+'※'*19);
        print(
          '''PS: Participant type is set to default.(ie,Learner)'''
          );
        print('※'*51);
        isMentor=false;
        pauseExecution(1000);
    }
  }

  void _setAvailableTime(){    
    print('\n'+'+'*50);
    print(name +
      ''', Choose your available time:
      \t1.Morning\t2.Afternoon\t3.Evening'''
      );
    print('+'*50 + '\n');
    
    String number = stdin.readLineSync();

    switch(number){
      case '1':      
        _time='Morning';
        break;
      case '2':
        _time='Afternoon';
        break;
      case '3':
        _time='Evening';
        break;
      default:
        pauseExecution(750);
        print('\n'+'※'*19+' Wrong Input!'+'※'*19);
        print(
          '''PS: Available time is set to default.(ie,Evening)'''
          );
        print('※'*51);
        _time='Evening';
        pauseExecution(1000);
    }
  }

  void getMentor(String rstack,String rtime){
    var count=0;
    if(isMentor){
      print('\n'+'‽'*50+'\nThis feature is not available to a Mentor\n'+'‽'*50);
    }
    else{
      pauseExecution(1000);
      print('⩖'*13+' Available Mentors List '+'⩖'*13);
      mentorlist.forEach((item){
        if(item.stack==rstack && item._time==rtime){
          print('\t'+ (count+1).toString()+ '\t'+item.name+'\t'+item.stack);
          count++;
        }
      });
      if(count==0)
        print("None");      
      print('⩕'*50);
    }
  }
}

void pauseExecution(int millisecond){
  sleep(new Duration(milliseconds: millisecond));
}

void showParticipantList(){
  var count = 1 ;

  pauseExecution(750);
  print('\n'+'⁛'*16+'Participants List'+'⁛'*16);
  mentorlist.forEach((item){
    print(count.toString()+'\t'+item.name+'\tMentor'+'\t'+item.stack+'\t'+item._time);
    count++;
  });
  learnerlist.forEach((item){
    print(count.toString()+'\t'+item.name+'\tLearner'+'\t'+item.stack);
    count++;
  });
  print('⁛'*50);
  pauseExecution(1000);
}

List chooseLearner(){
  var count=1;
  var selected;
  String freeTime;

  print('\n'+'⩖'*17+' Choose Learner '+'⩖'*17);
  learnerlist.forEach((item){
    print('\t'+count.toString()+'\t'+item.name+'\t'+item.stack);
    count++;
    });
  print('⩕'*50);

  while(true){
    try{
      var number = int.parse(stdin.readLineSync());

      if(number>0 && number<count){
        selected=number;
        break;
      }
      else{
        print('Enter a Valid Choice:');
        continue;
      }
    }catch(e){
      print('Enter Valid Number:');
      continue;
    }    
  }

  print('\n'+'+'*50);
  var name=learnerlist[selected-1].name;   
  print(
    '''Choose $name's Free Time
    \t1.Morning\t2.Afternoon\t3.Evening'''
  );
  print('+'*50 + '\n');

  while(true){
    try{
      var number = int.parse(stdin.readLineSync());

      if(number==1){
        freeTime='Morning';
        break;
      }
      else if(number==2){
        freeTime='Afternoon';
        break;
      }
      else if(number==3){
        freeTime='Evening';
        break;
      }
      else{
        print('Enter a Valid Choice:');
        continue;
      }
    }catch(e){
      print('Enter Valid Number:');
      continue;
    }
  }

  return [learnerlist[selected-1],learnerlist[selected-1].name,learnerlist[selected-1].stack,freeTime];
}

void main(){
  
  while(true){
    String participantName;
    
    print('\n'+'+'*50);
    print(
      '''Enter your Choice
      \t1.Create Participant
      \t2.Show Participant List
      \t3.Exit to choose Learner'''
    );
    print('+'*50 + '\n');

    try{
      var number = int.parse(stdin.readLineSync());
      if(number==1){
        print("Enter Participant's Name");
        participantName = stdin.readLineSync();
        Participant(participantName);
        continue;
      }
      else if(number==2){
        if(mentorlist.length>0 || learnerlist.length>0){
          showParticipantList();
          continue;
        }
        else{
          print('No Participants Available');
          continue;
        }
      }
      else if(number==3){
        if(mentorlist.length>0 || learnerlist.length>0)
          break;
        else{
          print('No Participants Available');
          continue;
        }
      }
      else{
        print('Enter a Valid Choice:');
        continue;
      }
    }catch(e){
      print('Enter Valid Number:');
      continue;
    }
  }
 
  var selectedLearner = chooseLearner();
  var learnerInstance = selectedLearner[0];
  var learnerName = selectedLearner[1];
  var learnerStack = selectedLearner[2];
  var learnerTime = selectedLearner[3];
  print('\nFor $learnerName');
  learnerInstance.getMentor(learnerStack,learnerTime);
}