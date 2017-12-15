USE `Moba` ;

insert into hero(name, health, mana, damage, defense, speed, passive, spell1, spell2, spell3, spell4) values
    ('Garen', 500, 0, 67, 30, 345, 'Healing', 'Silence and speed', 'Defense boost', 'Spin', 'Finisher'),
    ('Kassadin', 350, 200, 20, 20, 315, 'Mana bonus', 'Silence and damage', 'Mana restore', 'Slow', 'Teleport'),
    ('Soraka', 300, 200, 15, 19, 320, 'Bonus heal', 'Heal target', 'Slow area', 'Silence area', 'Heal everyone'),
    ('Vayne', 310, 150, 60, 20, 310, 'Bonus speed when chasing', 'Roll', 'More damage', 'Push', 'Invisible and stronger'),
    ('Hecarim', 400, 150, 55, 30, 330, 'Bonus speed gives damage', 'Slash', 'Damage area', 'Run', 'Charge'),
    ('Annie', 330, 220, 34, 23, 300, 'Mana refund', 'Fire bolt', 'Flame cone', 'Shield', 'Summon a bear'),
    ('Dr. Mundo', 520, 0, 60, 35, 325, 'Health regen', 'Throw a cleaver', 'Fire aura', 'More damage', 'Big health regen'),
    ('Ziggs', 280, 300, 55, 20, 300, 'Stronger attack', 'Throw a bouncing bomb', 'Rocket jump', 'Mine field', 'Atomic bomb'),
    ('Caitlyn', 330, 200, 60, 23, 300, 'Headshot', 'Do damage in a line', 'Set a trap', 'Net trap', 'Sniper shot'),
    ('Blitzcrank', 410, 300, 40, 40, 320, 'Mana barier', 'Rocket grab', 'Run', 'Uppercut', 'Silence area'),
    ('Fizz', 310, 200, 45, 23, 322, 'Move through units', "Dash", "Damage over time", 'Double jump', 'Send a shark'),
    ('Nasus', 470, 230, 51, 40, 325, 'Life steal', 'Increase damage', 'Slow', 'Weaken', 'Become Anubis'),
    ('Ezrael', 300, 150, 58, 22, 305, 'Attack speed', 'Fire a bolt', 'Magic bolt', 'Teleport', 'Arcane barage'),
    ('Vladimir', 390, 0, 38, 33, 310, 'Bonus health gives damage', 'Transfusion', 'Immune', 'Charge damage', 'Plague')
;

-- source C:/Users/Dzoni/Documents/GitHub/pbp_moba/src/create.sql

insert into item(name, cost, health, defense, damage, mana, speed) values
    ('Arcane staff', 800, 10, 1, 60, 100, 0),
    ('Trinity force', 3600, 300, 0, 200, 200, 20),
    ('B.F. sword', 1650, 0, 0, 65, 0, 0),
    ('Phantom dancer', 3100, 0, 100, 300, 0, 50),
    ('Warmogs armor', 2900, 3000, 200, 10, 0, 0),
    ('Frozen hearth', 2200, 100, 300, 0, 500, 0),
    ('Rejuvenation bead', 5000, 350, 450, 220, 700, 99),
    ('Ludens echo', 3100, 0, 50, 150, 10, 15),
    ('Heart of gold', 850, 400, 10, 0, 0, 3)
;

insert into skins(heroId, cost, name, is_on_sale) values
    (1, 350, 'Juggernaut', 0),
    (2, 0, 'Default', 0),
    (3, 0, 'Default', 0),
    (4, 0, 'Default', 0),
    (5, 0, 'Default', 0),
    (6, 0, 'Default', 0),
    (7, 0, 'Default', 0),
    (8, 0, 'Default', 0),
    (9, 0, 'Default', 0),
    (10, 0, 'Default', 0),
    (11, 0, 'Default', 0),
    (12, 0, 'Default', 0),
    (13, 0, 'Default', 0),
    (14, 0, 'Default', 0),
    (5, 1820, 'Arcade', 1),
    (4, 1820, 'Arcade', 1),
    (10, 1050, 'Pool party', 0),
    (12, 1050, 'Pool party', 1),
    (10, 900, 'Totally not', 0),
    (7, 670, 'Boss', 0),
    (13, 3600, 'Pulsfire', 0)
;

insert into map(name, starting_gold, expected_game_length, min_game_length) values
    ('Summoners rift', 500, '00:35:00', '00:15:00'),
    ('Howling Abyss', 700, '00:25:00', '00:12:00'),
    ('The Twisted Treeline', 1250, '0:20:00', '00:10:00')
;



insert into player(name, level, experience, wins, losses, rank) values
    ('Kredenac', 30, 0, 2200, 1800, 3400),
    ('Vitrina', 30, 0, 2100, 1750, 3350),
    ('Bosancheros', 29, 555, 600, 533, 2100),
    ('Patuljak', 30, 0, 2000, 1900, 3900),
    ('xXxKingxXx', 30, 0, 2000, 1900, 3900),
    ('Baklja', 1, 150, 1, 0, 1260),
    ('NoobPL', 25, 355, 30, 160, 350),
    ('SavoNBGD', 15, 1050, 7, 13, 777),
    ('SKT T1 Rex0x', 30, 9, 1599, 1359, 2700),
    ('Sevajper', 30, 0, 1700, 1600, 2950),
    ('Ticma', 30, 0, 910, 920, 1430)
;
insert into player(name) values
    ('BojanV03')
;

insert into shop(map_id, item_id, can_buy_at_start)
    select 1, id, 1
    from item;

insert into `match`(first_team_won, team1_player1, team1_player2, team1_player3, team1_player4, team1_player5,
    team2_player1, team2_player2, team2_player3, team2_player4, team2_player5) values
     (1, 1,3,5,2,5,7,10,9,8,6),
     (1, 1,2,3,4,5,6,7,8,9,10),
     (0, 1,12,3,4,5,6,7,8,9,11),
     (0, 10,12,9,7,8,2,1,4,5,3)
;

insert into friendship(player1, player2, note1, note2) values
    (1, 2, 'Pro', 'Noob'),
    (2, 3, 'Gotivan', 'Smarac'),
    (1, 10, 'Support', 'Top'),
    (3, 10, 'Nema pojma', 'Top');
