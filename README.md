# My Bash scripts
Here is some of my Bash script creations

## Inverted Range
This script was made to solve one need that I have.\
Based on a list of numbers it creates an inverted list of ranges.

### Example:

**List**
>- 1
>- 2
>- 5
>- 8
>- 15
>- 20

**Inverted Range, from 1 to 20**
>- 3-4
>- 6-7
>- 9-14
>- 16-19

### Usage:
>./InvertedRange.sh <file> [max range] [y|s]
> -file - File with number list
> -max range - The last range number (optional, defaults to 100)
> -y - Break lines on ';'
> -s - Remove spaces after ';'

