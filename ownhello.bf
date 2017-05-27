Cell | 1   2   3   3   4  5  6   4   7   3   8  9  10
Int  | 72 101 108 108 111 32 87 111 114 108 100 33 10
ANSI | H   e   l   l   o  \s W   o   r   l   d  !  \n

Create H character (72) in cell 1
ie loop 7 times added 10 to cell 1
   then add 2 
+++++ ++  add 7 to cell 0 (our loop counter)
[ loop while cell 0 is not equal to 0
 > move to cell 1 
  +++++ +++++  add 10 to cell 1
 < move to cell 0
 - decrement loop counter
]
> move to cell 1 
++ add 2 to cell 1 

< move to cell 0

Create e character (101) in cell 2
ie loop 10 times added 10 to cell 2
   then add 1 
+++++ +++++  add 10 to cell 0 (our loop counter)
[ loop while cell 0 is not equal to 0
 >> move to cell 2 
  +++++ +++++  add 10 to cell 2
 << move to cell 0
 - decrement loop counter
]
>> move to cell 2 
+ increment cell 2 

<< move to cell 0

Create l character (108) in cell 3
ie loop 10 times added 10 to cell 3
   then add 8 
+++++ +++++  add 10 to cell 0 (our loop counter)
[ loop while cell 0 is not equal to 0
 >>> move to cell 3 
  +++++ +++++  add 10 to cell 3
 <<< move to cell 0
 - decrement loop counter
]
>>> move to cell 3 
+++++ +++ add 8 cell 3 
<<< move to cell 0

Create o character (111) in cell 4
ie loop 11 times added 10 to cell 4
   then add 1 
+++++ +++++ + add 11 to cell 0 (our loop counter)
[ loop while cell 0 is not equal to 0
 >>>> move to cell 4 
  +++++ +++++  add 10 to cell 4
 <<<< move to cell 0
 - decrement loop counter
]
>>>> move to cell 4 
+ increment cell 4 
<<<< move to cell 0

Create space character (32) in cell 5
ie loop 3 times added 10 to cell 5
   then add 3 
+++ add 3 to cell 0 (our loop counter)
[ loop while cell 0 is not equal to 0
 >>>>> move to cell 5 
  +++++ +++++  add 10 to cell 5
 <<<<< move to cell 0
 - decrement loop counter
]
>>>>> move to cell 5 
++ add 3 to cell 5 
<<<<<

Create W character (87) in cell 6
ie loop 3 times added 10 to cell 6
   then add 3 
+++++ +++ add 3 to cell 0 (our loop counter)
[ loop while cell 0 is not equal to 0
 >>>>> > move to cell 6 
  +++++ +++++  add 10 to cell 6
 <<<<< < move to cell 0
 - decrement loop counter
]
>>>>> > move to cell 6 
+++++ ++ add 3 to cell 6 
<<<<< <

// skip o we have it in cell 4

Create r character (111) in cell 7
ie loop 3 times added 10 to cell 7
   then add 3 
+++++ +++++ + add 3 to cell 0 (our loop counter)
[ loop while cell 0 is not equal to 0
 >>>>> >> move to cell 7 
  +++++ +++++  add 10 to cell 7
 <<<<< << move to cell 0
 - decrement loop counter
]
>>>>> >> move to cell 7 
++++ add 3 to cell 7 
<<<<< <<


// skip l we have it in cell 3

Create d character (100) in cell 8
ie loop 3 times added 10 to cell 8
   then add 3 
+++++ +++++ add 3 to cell 0 (our loop counter)
[ loop while cell 0 is not equal to 0
 >>>>> >>> move to cell 8 
  +++++ +++++  add 10 to cell 8
 <<<<< <<< move to cell 0
 - decrement loop counter
]

Create ! character (33) in cell 9
ie loop 3 times added 10 to cell 9
   then add 3 
+++ add 3 to cell 0 (our loop counter)
[ loop while cell 0 is not equal to 0
 >>>>> >>>> move to cell 9 
  +++++ +++++  add 10 to cell 9
 <<<<< <<<< move to cell 0
 - decrement loop counter
]
>>>>> >>>> move to cell 9 
+++ add 3 to cell 9 
<<<<< <<<<

Create \n character (10) in cell 9
ie loop 3 times added 10 to cell 9
   then add 3 
>>>>> >>>>> move to cell 9 
 +++++ +++++  add 10 to cell 9
<<<<< <<<<< move to cell 0

> . <
>> . <<
>>> . <<<
>>> . <<<
>>>> . <<<<
>>>>> . <<<<<
>>>>> > . < <<<<<
>>>> . <<<<
>>>>> >> . << <<<<<
>>> . <<<
>>>>> >>> . <<< <<<<<
>>>>> >>>> . <<<< <<<<<
>>>>> >>>>> . <<<<< <<<<<
>>>>> >>>>> > . < <<<<< <<<<<
