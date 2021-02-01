# Ghost Word Game

A command-line interface implementation of the game 'Ghost' using Ruby

## Rules

**Number of Players:** Unlimited

1. Players take turns providing letters to create a word fragment
- Letter placed have to continue the word (eg. if the fragment is 'GRAC', 'I' could be a valid letter as it can lead to the word 'GRACING'. 'P' would not be valid as 'GRACP' does not lead to any word.)
2. Players try to place letters without **completing** a word
- As in example above, if the fragment is 'GRAC', both 'E' and 'I' would be valid letters leading to 'GRACE' or 'GRACING'. However, if player places 'E' to form 'GRACE', he would lose the round having completed a word. On the other hand, placing 'I' would not lose the round as 'GRACI' is an incomplete word.
3. The player who completes a word loses the round
4. Loser of the round would receive a letter of 'GHOST' similar to how 'HORSE' is played in basketball
5. If a player reaches 'GHOST', he loses the game and is out of subsequent rounds

