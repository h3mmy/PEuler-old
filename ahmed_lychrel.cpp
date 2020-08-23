/* Tweaked code for one of my students to demonstrate some inefficiencies in his code */


#include <iostream>
#include <cmath>
#include <string>

// Declaring functions

long rev_num(long n);
bool is_palindrome(long n);
void order_parameters(long &first, long &second);
bool check_lychrel(long n, long limit);
long check_range(long start, long end, long limit, long &natural_cnt, long &pal_cnt);



// Declaring namespaces

using std::cin;
using std::cout;
using std::endl;



int main(){
    
/*************************************/

//prompts for the start, finish and limit values
//checks to assure that the start, finish and limit are all >= 1
//reprompts otherwise
//calls check_range
//outputs the total counts

long x,y,z, natural_pals, other_pals;
natural_pals = 0;
other_pals = 0;


while (true) {
	// THIS IS AN INFITE IO LOOP - GET OVER IT
	cout << "Enter a first, last, limit (All greater than 1): ";
	cin >> x >> y >> z;
	if ((x>1) and (y>1) and (z>1)){ break; } // This ends the infinite loop
	else {cout << endl << "Sorry. Input numbers greater than 1 or Ctrl+C to quit" << endl;} // Punishers non-instruction followers by keeping them in this infinite loop of hell.
	
}

cout << endl << "Searching for Lychrels: " << endl;
long num_lychrels = check_range(x, y, z, natural_pals, other_pals);

cout << "Number of Lychrels found: " << num_lychrels << endl << "Number of Natural palindromes: " << natural_pals << endl <<
	"Other Palindromes: " << other_pals << endl;

return 0;
}


long rev_num(long n) {
/*************************************/

// √ reverses the order of the digits of n, returns that reversed number

long rev_number = 0;

while ( n > 0) {
    // Needs commenting
    rev_number *= 10;
    rev_number += (n % 10);
    n /=10;
    }

return rev_number;

}




bool is_palindrome(long n){
/*************************************/

// √ returns true if the number is a palindrome, false otherwise
//*****calls rev_num

if ( n == rev_num(n) ) { return true; }
else{ return false; }    

}



void order_parameters(long &first, long &second){
/*************************************/

// If the first is greater than second, then the two numbers should be swapped

if (first > second) {
	long temp = first;
	first = second;
	second = temp;
}
	

}





bool check_lychrel(long n, long limit){
/*************************************/

//apply the 196 algorithm for limit iterations or until the number becomes a palindrome.
//returns true if the number of iterations exceeds the limit, false otherwise
//calls is_palindrome
//calls rev_num
n += rev_num(n);  
for (long i=0;i<=limit;i++) {
	// Run 196
	if (is_palindrome(n)){
		return false;
	}
	else {
		n += rev_num(n);
	}
} 
return true;

}




long check_range(long start, long end, long limit, long &natural_cnt, long &pal_cnt) {
/*************************************/

//checks each number in the range from start to finish to identify a potential Lychrel number
//prints any Lychrel numbers it finds
//returns the count of Lychrel numbers found in the range
//natural_cnt is set to the number of "natural" palindromes which occur such as 121, 323, etc., that is didn't require application of the algorithm
//pal_cnt is set to the number of non-natural palindromic numbers found by application of check_lychrel within the limit
//calls order_parameters
//calls check_lychrel
//calls is_palindrome

order_parameters(start, end);

long num_of_lychrels = 0;

for(long i=start;i<=end;i++){
	if (is_palindrome(i)){
		natural_cnt++;
	}
	if (check_lychrel(i,limit) == true) {
		cout << i << endl;
		num_of_lychrels++;
	}
	else {
		pal_cnt++;
	}
}
 
return num_of_lychrels;
 
}

