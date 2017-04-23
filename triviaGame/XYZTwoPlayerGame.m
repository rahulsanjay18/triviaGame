//
//  XYZTwoPlayerGame.m
//  triviaGame
//
//  Created by Rahul Shah on 6/1/15.
//  Copyright (c) 2015 RahulShah. All rights reserved.
//

#import "XYZTwoPlayerGame.h"

@interface XYZTwoPlayerGame ()

@end

@implementation XYZTwoPlayerGame

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isItPlayerOnesTurn = YES; //player one will go first, this sets that up
    
    _startButton.hidden = YES; //keeps start button hidden until names are entered
    
    _nextPlayerReadyButton.hidden = YES;
    
    index = 0; //used for question repeat check
    
    _displayAnswerChoice1.hidden = YES;
    
    _displayAnswerChoice2.hidden = YES;
    
    _displayAnswerChoice3.hidden = YES;
    
    _displayAnswerChoice4.hidden = YES;
    
 
    
    [_displayAnswerChoice1 setEnabled:NO]; //used so buttons dont show and look weird
    [_displayAnswerChoice2 setEnabled:NO];
    [_displayAnswerChoice3 setEnabled:NO];
    [_displayAnswerChoice4 setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)enterNames:(UIButton *)sender {
    UIAlertView * didNotEnterNames = [[UIAlertView alloc]initWithTitle:@"ERROR: Did not enter both player's names" message:@"Please enter names into both the player 1 and player 2 name fields" delegate:self cancelButtonTitle:@"Okay." otherButtonTitles:nil, nil];
    
    if([_enterPlayerOneName.text isEqualToString:@""] || [_enterPlayerTwoName.text isEqualToString:@""]){ //entering names error check
        
        [didNotEnterNames show];
        
    }else{//
    
    _enterPlayerOneName.hidden = YES; //changes text fields to labels so nothing can be edited
    _enterPlayerTwoName.hidden = YES;
    _enterButton.hidden = YES;
    _startButton.hidden = NO;
    _displayPlayerOneName.text = [NSString stringWithFormat:@"%@", _enterPlayerOneName.text]; //sets up labels
    
    _displayPlayerTwoName.text = [NSString stringWithFormat:@"%@", _enterPlayerTwoName.text];
    
    _scorePlayer1 = 0; //reset scores
    
    _scorePlayer2 = 0;
    
    [self enterScores]; //invokes score view setup
        
    }
    
}

-(void) enterScores{//this method is used for condensing code
    
    _displayPlayerOneScore.text = [NSString stringWithFormat:@"%i", _scorePlayer1]; //enters scores into the score display label
    
    _displayPlayerTwoScore.text = [NSString stringWithFormat:@"%i", _scorePlayer2];
    
}


- (IBAction)startGameButton:(UIButton *)sender {//starts game and does any necessary things before the game starts
    
    [self generateQuestion]; //gets questions
    
    _encouragingWordsLabel.text = [NSString stringWithFormat:@""];//clears anything the label said
    
    _startButton.hidden = YES;
    
    _nextPlayerReadyButton.hidden = YES;
    
    _displayAnswerChoice1.hidden = NO;
    
    _displayAnswerChoice2.hidden = NO;
    
    _displayAnswerChoice3.hidden = NO;
    
    _displayAnswerChoice4.hidden = NO; //rearranges/hides the buttons in preperation for game
    
    [_displayAnswerChoice1 setEnabled:YES];//enables answer choice buttons
    [_displayAnswerChoice2 setEnabled:YES];
    [_displayAnswerChoice3 setEnabled:YES];
    [_displayAnswerChoice4 setEnabled:YES];
    
}

-(void)generateQuestion{
    
    NSArray * questionArray = @[@"In what year was the Declaration of Independence written?", @"At the time of the Declaration of Independence, how many colonies existed in the newly formed United States?",@"Which country gave the colonies support against the British?", @"Which year was the US Constitution written?",@"In which year were the Confederate States of America formed to allow the continued use of slavery in the South?", @"In what year were women given the right to vote in the United States?",@"In which year did the United States enter World War I?", @"In what year did the Great Depression begin?", @"In which year did Japan attack the United States, leading to American entry into World War II?" ,@"In which year was the War on Terror declared?", @"Agricultural evidence of native people in South America, including the discovery of the cultivation of potatoes, dates to which period?", @"Which South American civilization occupied a large area in northern South America, stretching from modern day Colombia to Panama by the 300s CE?", @"Which civilization inhabited the northern coast of Peru from 0 - 500 CE, known for their human sacrifices and trade with the Maya?", @"Which civilization is known for their construction of Machu Picchu, incredible stonework, and terraced farming?", @"Which two European countries, under the direction of the Pope, began the slaughter of South American natives in the name of religious conversion?", @"Which country was responsible for building the first fort in Guyana?", @"Brazil was colonized by the Portuguese and gained independence in which year?", @"Guyana did not gain independence from the United Kingdom until which year?", @" Pizarro led the Spanish to slaughter the Inca and take control of Peru in which year?", @"In which year did Argentina declare independence from the Spanish?"]; //array of all the questions
    
    _generateQuestionArrayIndex= arc4random() % ([questionArray count] - 1); //generates random index number that tells
    
    for (int i = 0; (i <= index); i++) {//this guarentees no repeat questions for correctly answered questions
        
        if(_generateQuestionArrayIndex == noAnswerRepeats[i]){//A for loop is used to run through the entire array, and if the current index generated matches that of any of the values in the array, a new number is generated and the loop is set to restart
            
            _generateQuestionArrayIndex= arc4random() % ([questionArray count] - 1);
            
            i = 0;
            
        }
        
        _displayQuestion.text = [NSString stringWithFormat:@"Generating Question...\nIf you see this message for a while, then there are no more questions left, and the game finished. Thanks for playing."]; //in case the loop becomes infinite, this is left here
        
        
    }
    
    _displayQuestion.text = [questionArray objectAtIndex:_generateQuestionArrayIndex]; //displays the question
    
    [self answerChoicesGenerator];//after question is created, answers are generated
    
}
-(void)answerChoicesGenerator{//used to create the answer choices
    
    NSArray * answerChoiceArray1 = @[@"1492", @"13", @"Spain", @"1678", @"1775", @"1848", @"1899", @"1908", @"1928", @"1999", @"12,000s BCE", @"Caral", @"Caral", @"Nazca", @"France and Germany", @"Netherlands", @"1635", @"1883", @"1498", @"1917"];
    NSArray * answerChoiceArray2 = @[@"1675", @"15", @"France", @"1733", @"1809", @"1910", @"1908", @"1929", @"1935", @"2001", @"8,000s BCE", @"Chibchas", @"Chavin", @"Wari", @"Austria and Italy", @"Spain", @"1789", @"1912", @"1532", @"1906"];
    NSArray * answerChoiceArray3 = @[@"1776", @"27", @"Austria", @"1789", @"1852", @"1920", @"1917", @"1933", @"1939", @"2003", @"6,000s BCE", @"Canaris", @"Inca", @"Inca", @"Spain and Portugal", @"France", @"1822", @"1966", @"1617", @"1816"];
    NSArray * answerChoiceArray4 = @[@"1783", @"50", @"Italy", @"1806", @"1861", @"1939", @"1921", @"1939", @"1941", @"2005", @"4,000s BCE", @"Chavin", @"Moche", @"Moche", @"Sweden and Germany", @"Portugal", @"1912", @"1973", @"1769", @"1888"];//all possible answer choices for all possible questions are listed here.
    
    
    currentQuestion.answerChoice1 = [answerChoiceArray1 objectAtIndex:_generateQuestionArrayIndex];
    
    currentQuestion.answerChoice2 = [answerChoiceArray2 objectAtIndex:_generateQuestionArrayIndex];
    
    currentQuestion.answerChoice3 = [answerChoiceArray3 objectAtIndex:_generateQuestionArrayIndex];
    
    currentQuestion.answerChoice4 = [answerChoiceArray4 objectAtIndex:_generateQuestionArrayIndex];//got the appropriate answer choices entered into an object that holds the answer choices
    
    [_displayAnswerChoice1 setTitle : [answerChoiceArray1 objectAtIndex:_generateQuestionArrayIndex] forState : UIControlStateNormal]; //sets the title of the buttons to the answer choices
    
    [_displayAnswerChoice2 setTitle : [answerChoiceArray2 objectAtIndex:_generateQuestionArrayIndex] forState : UIControlStateNormal];
    
    [_displayAnswerChoice3 setTitle : [answerChoiceArray3 objectAtIndex:_generateQuestionArrayIndex] forState : UIControlStateNormal];
    
    [_displayAnswerChoice4 setTitle : [answerChoiceArray4 objectAtIndex:_generateQuestionArrayIndex] forState : UIControlStateNormal];
    
    
    
}

/*
 The following four methods do essentially the same thing, except whatever is being done is being done
 to a different number answer choice. First, the correct answers are declared and the index of the question
 generated is used to locate the correct answer for that particular question. Then it is compared to the
 button's title and checked if they are the same. If so, the code uses a boolean variable to determine who's
 turn it is and if/who gets the point. It adds whatever points needed, displays a message at the bottom
 of the screen and then invokes methods to log in the fact that the question is now used, as well as post-question
 work that needs to be done so that the next player can play as well
 
 
 */

-(IBAction)checkAnswer1:(UIButton *)sender{//refer to large block comment
    
    NSArray * answerArray = @[@"1776", @"13", @"France", @"1789", @"1861", @"1920", @"1917", @"1929", @"1941", @"2001", @"6,000 BCE", @"Chibchas", @"Moche", @"Inca", @"Spain and Portugal", @"Netherlands", @"1822", @"1966", @"1532", @"1816"];
    
    
    
    
    if([_displayAnswerChoice1.titleLabel.text isEqualToString:[answerArray objectAtIndex:_generateQuestionArrayIndex]]){
        
        _encouragingWordsLabel.text = [NSString stringWithFormat:@"Good Job!"];
        
        
        if(_isItPlayerOnesTurn){
            
            _scorePlayer1++;
            
            _isItPlayerOnesTurn = NO;
            
        }else{
            
            _scorePlayer2++;
            
            _isItPlayerOnesTurn = YES;
        
        }
        
        [self addRepeatCorrectAnswersToArray];
        
        
    }else{
        
        
        _encouragingWordsLabel.text = [NSString stringWithFormat:@"Wrong."];
        
        
        if(_isItPlayerOnesTurn){
            
            _isItPlayerOnesTurn = NO;
            
        }else{
            
            _isItPlayerOnesTurn = YES;
            
        }
        
        
    }
    
[self aftermathOfAnswerCheck];

}

-(IBAction)checkAnswer2:(UIButton *)sender{//refer to large block comment
    
    
    NSArray * answerArray = @[@"1776", @"13", @"France", @"1789", @"1861", @"1920", @"1917", @"1929", @"1941", @"2001", @"6,000 BCE", @"Chibchas", @"Moche", @"Inca", @"Spain and Portugal", @"Netherlands", @"1822", @"1966", @"1532", @"1816"];
    
    
    
    
    if([_displayAnswerChoice2.titleLabel.text isEqualToString:[answerArray objectAtIndex:_generateQuestionArrayIndex]]){
        
        _encouragingWordsLabel.text = [NSString stringWithFormat:@"Good Job!"];
        
        
        if(_isItPlayerOnesTurn){
            
            _scorePlayer1++;
            
            _isItPlayerOnesTurn = NO;
            
        }else{
            
            _scorePlayer2++;
            
            _isItPlayerOnesTurn = YES;
            
        }
        
        [self addRepeatCorrectAnswersToArray];
        
    }else{
        
        
        _encouragingWordsLabel.text = [NSString stringWithFormat:@"Wrong."];
        
        
        if(_isItPlayerOnesTurn){
            
            _isItPlayerOnesTurn = NO;
            
        }else{
            
            _isItPlayerOnesTurn = YES;
            
        }
        
        
    }
    
    [self aftermathOfAnswerCheck];
}

-(IBAction)checkAnswer3:(UIButton *)sender{//refer to large block comment
    
    
    NSArray * answerArray = @[@"1776", @"13", @"France", @"1789", @"1861", @"1920", @"1917", @"1929", @"1941", @"2001", @"6,000 BCE", @"Chibchas", @"Moche", @"Inca", @"Spain and Portugal", @"Netherlands", @"1822", @"1966", @"1532", @"1816"];
    
    
    
    
    if([_displayAnswerChoice3.titleLabel.text isEqualToString:[answerArray objectAtIndex:_generateQuestionArrayIndex]]){
        
        _encouragingWordsLabel.text = [NSString stringWithFormat:@"Good Job!"];
        
        
        if(_isItPlayerOnesTurn){
            
            _scorePlayer1++;
            
            _isItPlayerOnesTurn = NO;
            
        }else{
            
            _scorePlayer2++;
            
            _isItPlayerOnesTurn = YES;
            
        }
        
        [self addRepeatCorrectAnswersToArray];
        
    }else{
        
        
        _encouragingWordsLabel.text = [NSString stringWithFormat:@"Wrong."];
        
        
        if(_isItPlayerOnesTurn){
            
            _isItPlayerOnesTurn = NO;
            
        }else{
            
            _isItPlayerOnesTurn = YES;
            
        }
        
        
    }
    
    [self aftermathOfAnswerCheck];
    
}

-(IBAction)checkAnswer4:(UIButton *)sender{//refer to large block comment
    
    
    NSArray * answerArray = @[@"1776", @"13", @"France", @"1789", @"1861", @"1920", @"1917", @"1929", @"1941", @"2001", @"6,000 BCE", @"Chibchas", @"Moche", @"Inca", @"Spain and Portugal", @"Netherlands", @"1822", @"1966", @"1532", @"1816"];
    
    
    
    
    if([_displayAnswerChoice4.titleLabel.text isEqualToString:[answerArray objectAtIndex:_generateQuestionArrayIndex]]){
        
        _encouragingWordsLabel.text = [NSString stringWithFormat:@"Good Job!"];
        
        
        if(_isItPlayerOnesTurn){
            
            _scorePlayer1++;
            
            _isItPlayerOnesTurn = NO;
            
        }else{
            
            _scorePlayer2++;
            
            _isItPlayerOnesTurn = YES;
            
        }
        
        [self addRepeatCorrectAnswersToArray];
        
    }else{
        
        
        _encouragingWordsLabel.text = [NSString stringWithFormat:@"Wrong."];
        
        
        if(_isItPlayerOnesTurn){
            
            _isItPlayerOnesTurn = NO;
            
        }else{
            
            _isItPlayerOnesTurn = YES;
            
        }
        
        
    }
    
    [self aftermathOfAnswerCheck];
    
    
}

-(IBAction)backgroundTap:(id)sender{
    
    [_enterPlayerOneName resignFirstResponder]; //gets rid of keyboards when the background is tapped
    
    [_enterPlayerTwoName resignFirstResponder];
    
    
}

-(void)aftermathOfAnswerCheck{
    
    
    [self enterScores];
    
    if(_scorePlayer1 == 5){//checks if someone won the game
        
        _encouragingWordsLabel.text = [NSString stringWithFormat:@"PLAYER ONE WINS!"];
                
    }else if (_scorePlayer2 == 5){
        
        _encouragingWordsLabel.text = [NSString stringWithFormat:@"PLAYER TWO WINS!"];
        

        
    }else{
        
        _nextPlayerReadyButton.hidden = NO; //allows next player to begin their turn
        
        _displayQuestion.text = [NSString stringWithFormat:@"Pass to next player"]; //prompts them to begin their turn
        
    }
    
    [self disableButtons]; //invokes disable method
    
}
-(void)disableButtons{
    
    
    [_displayAnswerChoice1 setEnabled:NO]; //this is mainly done so that players cannot keep adding points to their score by continuously clicking the correct answer's button
    [_displayAnswerChoice2 setEnabled:NO];
    [_displayAnswerChoice3 setEnabled:NO];
    [_displayAnswerChoice4 setEnabled:NO];
    
}

-(void)addRepeatCorrectAnswersToArray{
    
    noAnswerRepeats[index] = _generateQuestionArrayIndex;
    //logs in correctly answered question's index
    index++;//adds one to the index so the for loop can go through all of the array
    
}
@end