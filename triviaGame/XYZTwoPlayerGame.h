//
//  XYZTwoPlayerGame.h
//  triviaGame
//
//  Created by Rahul Shah on 6/1/15.
//  Copyright (c) 2015 RahulShah. All rights reserved.
//

#import "XYZViewController.h"

@interface XYZTwoPlayerGame : XYZViewController
{
    
    XYZTwoPlayerGame * currentQuestion;
    
    int noAnswerRepeats[20];
    
    int index;
}

@property (weak, nonatomic) IBOutlet UITextField *enterPlayerOneName;

@property (weak, nonatomic) IBOutlet UITextField *enterPlayerTwoName;

@property (weak, nonatomic) IBOutlet UILabel *displayPlayerOneName;

@property (weak, nonatomic) IBOutlet UILabel *displayPlayerTwoName;

@property (weak, nonatomic) IBOutlet UILabel *displayPlayerOneScore;

@property (weak, nonatomic) IBOutlet UILabel *displayPlayerTwoScore;

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UILabel *displayQuestion;

@property (weak, nonatomic) IBOutlet UIButton *displayAnswerChoice1;

@property (weak, nonatomic) IBOutlet UIButton *displayAnswerChoice2;

@property (weak, nonatomic) IBOutlet UIButton *displayAnswerChoice3;

@property (weak, nonatomic) IBOutlet UIButton *displayAnswerChoice4;

@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@property (weak, nonatomic) IBOutlet UILabel *encouragingWordsLabel;

@property (weak, nonatomic) IBOutlet UIButton *nextPlayerReadyButton;

@property (weak, nonatomic) IBOutlet UIButton *backToTheMainMenu;

//UI @property declaration statements. Will accept user input to operate the game

@property int scorePlayer1, scorePlayer2;

@property int generateQuestionArrayIndex;

@property _Bool isItPlayerOnesTurn;

@property NSString * answerChoice1;

@property NSString * answerChoice2;

@property NSString * answerChoice3;

@property NSString * answerChoice4;
//These other variables will be manipulated in the code to make the game work


- (IBAction)enterNames:(UIButton *)sender; //sets the name labels and sets scores

-(void)enterScores; //physically enters the scores into the labels

-(void)generateQuestion;

-(void)answerChoicesGenerator;

- (IBAction)startGameButton:(UIButton *)sender; //starts game and does any setup needed for the game

-(IBAction)checkAnswer1:(UIButton *)sender; //one button per answer choice so that it checks the correct answer

-(IBAction)checkAnswer2:(UIButton *)sender;

-(IBAction)checkAnswer3:(UIButton *)sender;

-(IBAction)checkAnswer4:(UIButton *)sender;

-(void)aftermathOfAnswerCheck; //disappear/reappearing of buttons, passing to next player, entering scores

-(void)disableButtons; //This and the method before were created to condense code

-(IBAction)backgroundTap:(id)sender;

@end
