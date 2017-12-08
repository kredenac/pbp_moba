#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>
#include <stdarg.h>
#include <errno.h>

const char * leaderboards_query = "select name, rank from player order by rank desc";

const char * match_history_query =
"select case"
" when %s in (team1_player1, team1_player2, team1_player3, team1_player4, team1_player5)"
" then"
    " case when (first_team_won = 1)"
        " then 'victory'"
        " else 'defeat'"
    " end"
" else"
    " case when (1 - first_team_won = 1)"
        " then 'victory'"
        " else 'defeat'"
    " end"
" end as result,"
" p1.name, p2.name, p3.name, p4.name, p5.name, p6.name, p7.name, p8.name, p9.name, p10.name"
" from `match`, player p1, player p2, player p3, player p4, player p5, player p6, player p7, player p8, player p9, player p10"
" where %s in (team1_player1, team1_player2, team1_player3, team1_player4, team1_player5,"
" team2_player1, team2_player2, team2_player3, team2_player4, team2_player5)"
" and p1.id = team1_player1 and p2.id = team1_player2 and p3.id =  team1_player3 and p4.id = team1_player4 and p5.id = team1_player5 and"
" p6.id = team2_player1 and p7.id = team2_player2 and p8.id =  team2_player3 and p9.id =  team2_player4 and p10.id = team2_player5";
