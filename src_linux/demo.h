#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>
#include <stdarg.h>
#include <errno.h>

const char * leaderboards_query = "select name, rank from Player order by rank desc";

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
" from `Match`, Player p1, Player p2, Player p3, Player p4, Player p5, Player p6, Player p7, Player p8, Player p9, Player p10"
" where %s in (team1_player1, team1_player2, team1_player3, team1_player4, team1_player5,"
" team2_player1, team2_player2, team2_player3, team2_player4, team2_player5)"
" and p1.id = team1_player1 and p2.id = team1_player2 and p3.id =  team1_player3 and p4.id = team1_player4 and p5.id = team1_player5 and"
" p6.id = team2_player1 and p7.id = team2_player2 and p8.id =  team2_player3 and p9.id =  team2_player4 and p10.id = team2_player5";

const char * insert_match_query =
"insert into `Match`(first_team_won, team1_player1, team1_player2, team1_player3,"
     " team1_player4, team1_player5,"
    " team2_player1, team2_player2, team2_player3, team2_player4, team2_player5) values"
    " (%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)";

const char * insert_item_query =
"insert into Item(name, cost, health, defense, damage, mana, speed) values"
" ('%s', %d, %d, %d, %d, %d, %d)";

const char * delete_item_query =
"delete from Item where name like '%s'";
