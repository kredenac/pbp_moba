USE `Moba` ;

delimiter $$

drop procedure if exists update_player_elo_and_games$$
-- call update_player_elo(1, 3500, 3500, 1);
-- \W ukljuci warninge, \w iskljuci
create procedure update_player_elo_and_games (playerId INT, playerTeamElo INT, enemyTeamElo INT, playerWon TINYINT(1))
begin
    declare tRank1 double;
    declare tRank2 double;
    declare expected1 float;
    declare expected2 float;
    declare newRankDiff float;
    declare K int;
    declare currentRank int;

    -- formula po kojoj racunam novi rank(odnosno elo)  igraca.
    set currentRank = (select rank from Player where id = playerId);
    set tRank1 = pow(10, (playerTeamElo + currentRank)/800);
    set tRank2 = pow(10, enemyTeamElo/400);

    set expected1 = tRank1 / (tRank1 + tRank2);
    -- set expected2 = tRank2 / (tRank1 + tRank2);
    set K = (select level from Player where playerId = id);
    set newRankDiff =  79 * (playerWon - expected1);

    update Player
    set rank = rank + ceil(newRankDiff),
    wins = wins + playerWon,
    losses = losses + (1 - playerWon),
    experience = IF(level = 30, 0, experience + 17),
    level = IF(level = 30, 30, if(experience > K*20, K +1, K)),
    experience = IF(level = 30, 0, if(experience > K*20, experience - K*20, experience))
    where id = playerId;
end$$


drop trigger if exists hash_password_insert $$

create trigger hash_password_insert before insert on Player
for each row begin
    set new.password = MD5(new.password);
end$$


drop trigger if exists hash_password_update$$

create trigger hash_password_update before update on Player
for each row begin
    if (new.password <> old.password) then
        set new.password = MD5(new.password);
    end if;
end$$

drop trigger if exists friendship_order_insert$$

create trigger friendship_order_insert before insert on Friendship
for each row begin
    declare tmp int;
    declare  tmpNote varchar(200);
    if (new.player1 = new.player2) then
        signal sqlstate '45000' set message_text = 'Cant be a friend with self';
    end if;

    if (new.player1 < new.player2) then
        set tmp = new.player1;
        set tmpNote = new.note1;
        set new.note1 = new.note2;
        set new.note2 = tmpNote;
        set new.player1 = new.player2;
        set new.player2 = tmp;
    end if;
end$$

drop trigger if exists friendship_order_update$$

create trigger friendship_order_update before update on Friendship
for each row begin
    declare tmp int;
    declare  tmpNote varchar(200);
    if (new.player1 = new.player2) then
        signal sqlstate '45000' set message_text = 'Cant be a friend with self';
    end if;
    if (new.player1 < new.player2) then
        set tmp = new.player1;
        set tmpNote = new.note1;
        set new.note1 = new.note2;
        set new.note2 = tmpNote;
        set new.player1 = new.player2;
        set new.player2 = new.player1;
    end if;
end$$

drop trigger if exists match_ended$$

create trigger match_ended after insert on `Match`
for each row begin
    declare team1Elo int;
    declare team2Elo int;
    set team1Elo = floor((select SUM(rank) from Player
        where id in ( new.team1_player1,  new.team1_player2,  new.team1_player3,  new.team1_player4,  new.team1_player5) )
        /5);
    set team2Elo = floor((select SUM(rank) from Player
        where id in ( new.team2_player1,  new.team2_player2,  new.team2_player3,  new.team2_player4,  new.team2_player5) )
        /5);
    -- update_player_elo_and_games (playerId INT, playerTeamElo INT, enemyTeamElo INT, playerWon TINYINT(1))

    call update_player_elo_and_games(new.team1_player1, team1Elo, team2Elo, new.first_team_won);
    call update_player_elo_and_games(new.team1_player2, team1Elo, team2Elo, new.first_team_won);
    call update_player_elo_and_games(new.team1_player3, team1Elo, team2Elo, new.first_team_won);
    call update_player_elo_and_games(new.team1_player4, team1Elo, team2Elo, new.first_team_won);
    call update_player_elo_and_games(new.team1_player5, team1Elo, team2Elo, new.first_team_won);

    call update_player_elo_and_games(new.team2_player1, team1Elo, team2Elo, not new.first_team_won);
    call update_player_elo_and_games(new.team2_player2, team1Elo, team2Elo, not new.first_team_won);
    call update_player_elo_and_games(new.team2_player3, team1Elo, team2Elo, not new.first_team_won);
    call update_player_elo_and_games(new.team2_player4, team1Elo, team2Elo, not new.first_team_won);
    call update_player_elo_and_games(new.team2_player5, team1Elo, team2Elo, not new.first_team_won);

end$$

delimiter ;
