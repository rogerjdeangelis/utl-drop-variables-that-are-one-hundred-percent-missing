%let pgm=utl-drop-variables-that-are-one-hundred-percent-missing;

Drop variables that are one hundred percent missing

github
https://tinyurl.com/yhtuh3pv
https://github.com/rogerjdeangelis/utl-drop-variables-that-are-one-hundred-percent-missing

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

data class;

  set sashelp.class;

  sex="";
  weight=.;

run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* DROP CHAR VARIABLE SEX AND NUMERIC VARIABLE WEIGHT                                                                     */
/*                                                                                                                        */
/*  Up to 40 obs from CLASS total obs=19 17MAR2022:13:11:47                                                               */
/*                                                                                                                        */
/*  Obs    NAME       SEX    AGE    HEIGHT    WEIGHT                                                                      */
/*                                                                                                                        */
/*    1    Alfred             14     69.0        .                                                                        */
/*    2    Alice              13     56.5        .                                                                        */
/*    3    Barbara            13     65.3        .                                                                        */
/*    4    Carol              14     62.8        .                                                                        */
/*    5    Henry              14     63.5        .                                                                        */
/*    6    James              12     57.3        .                                                                        */
/*    7    Jane               12     59.8        .                                                                        */
/*    8    Janet              15     62.5        .                                                                        */
/*    9    Jeffrey            13     62.5        .                                                                        */
/*   10    John               12     59.0        .                                                                        */
/*   11    Joyce              11     51.3        .                                                                        */
/*   12    Judy               14     64.3        .                                                                        */
/*   13    Louise             12     56.3        .                                                                        */
/*   14    Mary               15     66.5        .                                                                        */
/*   15    Philip             16     72.0        .                                                                        */
/*   16    Robert             12     64.8        .                                                                        */
/*   17    Ronald             15     67.0        .                                                                        */
/*   18    Thomas             11     57.5        .                                                                        */
/*   19    William            15     66.5        .                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/**************************************************************************************************************************/
/*           _                               _ _       _                                                                  */
/*  (_)_ __ | |_ ___ _ __ _ __ ___   ___  __| (_) __ _| |_ ___                                                            */
/*  | | `_ \| __/ _ \ `__| `_ ` _ \ / _ \/ _` | |/ _` | __/ _ \                                                           */
/*  | | | | | ||  __/ |  | | | | | |  __/ (_| | | (_| | ||  __/                                                           */
/*  |_|_| |_|\__\___|_|  |_| |_| |_|\___|\__,_|_|\__,_|\__\___|                                                           */
/*                                                                                                                        */
/*                                                                                                                        */
/*  PROC FREQ                                                                                                             */
/*  Up to 40 obs WORK.HAVMIS total obs=2 17MAR2022:13:19:05                                                               */
/*                                                                                                                        */
/*                     NUMBER_OF_                                                                                         */
/*                        NON_                                                                                            */
/*                      MISSING_                                                                                          */
/*  Obs    TABLEVAR      VALUES                                                                                           */
/*                                                                                                                        */
/*   1      SEX             0                                                                                             */
/*   2      WEIGHT          0                                                                                             */
/*    __ _             _                                                                                                  */
/*   / _(_)_ __   __ _| |                                                                                                 */
/*  | |_| | `_ \ / _` | |                                                                                                 */
/*  |  _| | | | | (_| | |                                                                                                 */
/*  |_| |_|_| |_|\__,_|_|                                                                                                 */
/*                                                                                                                        */
/* Up to 40 obs WORK.WANT total obs=19 17MAR2022:13:20:27                                                                 */
/*                                                                                                                        */
/* Obs    NAME       AGE    HEIGHT                                                                                        */
/*                                                                                                                        */
/*   1    Alfred      14     69.0                                                                                         */
/*   2    Alice       13     56.5                                                                                         */
/*   3    Barbara     13     65.3                                                                                         */
/*   4    Carol       14     62.8                                                                                         */
/*   5    Henry       14     63.5                                                                                         */
/*   6    James       12     57.3                                                                                         */
/*   7    Jane        12     59.8                                                                                         */
/*   8    Janet       15     62.5                                                                                         */
/*   9    Jeffrey     13     62.5                                                                                         */
/*  10    John        12     59.0                                                                                         */
/*  11    Joyce       11     51.3                                                                                         */
/*  12    Judy        14     64.3                                                                                         */
/*  13    Louise      12     56.3                                                                                         */
/*  14    Mary        15     66.5                                                                                         */
/*  15    Philip      16     72.0                                                                                         */
/*  16    Robert      12     64.8                                                                                         */
/*  17    Ronald      15     67.0                                                                                         */
/*  18    Thomas      11     57.5                                                                                         */
/*  19    William     15     66.5                                                                                         */
/*                                                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*         _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| `_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

*/

ods select none;
ods output nlevels=havMis(

             keep   = TableVar NNonMissLevels
             rename = NNonMissLevels = Number_of_Non_Missing_Values
             where  = (Number_of_Non_Missing_Values=0))
;
proc freq data=class nlevels;
tables _all_;
run;
ods select all;

%array(_drp,data=havMis,var=tablevar);

%put &_drpn;
%put &_drp1;

data want;
  set class(drop= %do_over(_drp,phrase=?) );
run;quit;

%arraydelete(_drp);

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
