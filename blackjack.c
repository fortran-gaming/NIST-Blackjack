#include <stdio.h>
#include <stdlib.h>

extern void hit(int*, int*, int*, int []);

extern void mix(int []);


int hand(int cards [])
{/* return win */
int d = 0, p = 0, pace = 0, dace = 0, win = 0, i=1;
/* win will be 0 if dealer wins, 1 if player wins, 2 if a push */

hit(&p, &pace, &i, &cards[0]);
hit(&d, &dace, &i, &cards[0]);
hit(&p, &pace, &i, &cards[0]);
hit(&d, &dace, &i, &cards[0]);
int count = 0;

printf("DEALER SHOWS --- %d\n", cards[i-1]);

printf("PLAYER = %d, NO OF ACES - %d\n", p, pace);

if (p == 21) {

printf("PLAYER HAS BLACKJACK\n");

win = 1;
} else {

count = 2;

while (1) {
printf("hit? ");
int fHit = getchar();
getchar(); // discard EOF

if (fHit != 'y') break;

hit(&p,&pace,&i, &cards[0]);

count += 1;

printf("PLAYER = %d, NO OF ACES - %d\n", p, pace);

if (p > 21) {

printf("PLAYER BUSTS - DEALER WINS\n");

return win;
}

}

}
/* Handle blackjack situations, case when dealer has blackjack */

if (d == 21) {

printf("DEALER HAS BJ\n");

if (win == 1) {

printf("------ PUSH\n");

win = 2;

return win;
} else {

printf("DEALER AUTOMATICALLY WINS\n");

return win;

}
} else {
/* case where dealer doesn't have blackjack:
* check for player blackjack or five card hand
*/

if (p == 21 || count >= 5) {

printf("PLAYER AUTOMATICALLY WINS\n");

win = 1;

return win;
}

}

printf("DEALER HAS %d\n", d);


while (d <= 16) {

hit(&d,&dace,&i, &cards[0]);

if (d > 21) {

printf("DEALER BUSTS - PLAYER WINS\n");

win = 1;

return win;
}

}

printf(" PLAYER = %d DEALER = %d\n", p, d);

if (p > d) {

printf("PLAYER WINS\n");

win = 1;
} else

printf("DEALER WINS\n");

return win;

}


int main(void){

int cards[52];

mix(&cards[0]);

//for(int j = 0; j < 52; j++)
//  printf("%d ", cards[j]);
//printf("\n");

int win = hand(cards);

printf("Win code: %d \n", win);

return 0;

}
