#include "demo.h"
#include "time.h"
//TAKO GA COMPILE
//gcc 1.c -lmysqlclient
//gcc 1.c -lmysqlclient
//gcc 1.c -lmysqlclient
#define QUERY_SIZE 2048

#define BUFFER_SIZE 128

/* Funkcija error_fatal() ispisuje poruku o gresci i potom prekida program. */
static void error_fatal (char *format, ...);

void change_password(MYSQL *connection);
void see_match_history(MYSQL *connection);
void view_leaderboards(MYSQL *connection);
void print_result(MYSQL_RES *result, int mark_order);
void select_all_from_player(MYSQL *connection);
void insert_new_match(MYSQL *connection);
void shuffle(int *array, size_t n);
void delete_item(MYSQL *connection);
void insert_new_item(MYSQL *connection);

int main (int argc, char **argv)
{
    MYSQL *connection;	/* Promenljiva za konekciju. */
    /* Incijalizuje se promenljiva koja ce prowstavljati konekciju. */
    connection = mysql_init (NULL);
    if (connection == NULL){
      printf("connection JE NULL >:(");
      error_fatal ("Greska u konekciji. %s\n", mysql_error (connection));
    }
    /* Pokusava se sa konektovanjem na bazu. */
    if (mysql_real_connect(connection, "127.0.0.1", "root", "1234", "moba",
        0, NULL,0) == NULL){
        error_fatal ("Greska u konekciji. %s\n", mysql_error (connection));
    }
    srand(time(NULL));
    int option;
    int running = 1;
    while(running){
        printf("\nChose by inputing a number:\n");
        printf("1. Change your password\n");
        printf("2. View all players\n");
        printf("3. See match history of a player\n");
        printf("4. View Leaderboards\n");
        printf("5. Delete item\n");
        printf("6. Insert new item\n");
        printf("7. Insert a new match\n");
        printf("0. Quit\n");
        scanf("%d", &option);
        switch (option) {
            case 1:
                change_password(connection);
                break;
            case 2:
                select_all_from_player(connection);
                break;
            case 3:
                see_match_history(connection);
                break;
            case 4:
                view_leaderboards(connection);
                break;
            case 5:
                delete_item(connection);
                break;
            case 6:
                insert_new_item(connection);
                break;
            case 7:
                insert_new_match(connection);
                break;
            case 0:
                running = 0;
                break;
            default:
                printf("Wrong input\n");
                break;
        }
    }
    mysql_close (connection);
    exit(EXIT_SUCCESS);
}

void print_result(MYSQL_RES *result, int mark_order)
{
    MYSQL_FIELD *field;
    MYSQL_ROW row;

    row = mysql_fetch_row(result);
    if (row == 0){
        printf("Wrong username or pass\n");
        return;
    }

    if (mark_order){
        printf("%-13s|", "place");
    }
    while( NULL != (field = mysql_fetch_field(result))){
        printf("%-13s|", field->name);
    }
    printf("\n");
    int num_fields = mysql_num_fields(result);

    int i=0;
    while (row){
        if (mark_order){
            printf("%-13d|", ++i);
        }
        for (int i=0; i<num_fields; i++){
            printf ("%-13s|", row[i] ? row[i] : "NULL");
        }
        printf ("\n");
        row = mysql_fetch_row(result);
    }

    printf ("\n");
}

void view_leaderboards(MYSQL *connection)
{
    MYSQL_RES *result;
    if (mysql_query (connection, leaderboards_query) != 0){
        error_fatal ("Error in query %s\n", mysql_error (connection));
    }
    result = mysql_use_result (connection);

    printf("Leaderboards:\n");
    print_result(result, 1);
    mysql_free_result (result);
}

void see_match_history(MYSQL *connection)
{
    MYSQL_RES *result;
    MYSQL_ROW row;
    char bufferName[BUFFER_SIZE];
    char query[QUERY_SIZE];

    printf("Match history:\n");
    printf("Enter your account name\n");
    scanf("%s", bufferName);

    sprintf (query, "select id from player where name = '%s'", bufferName);

    if (mysql_query (connection, query) != 0){
        error_fatal ("Error in query %s\n", mysql_error (connection));
    }
    result = mysql_use_result (connection);

    row = mysql_fetch_row(result);
    if (row == 0){
        printf("Wrong username\n");
        return;
    }
    printf("id = '%s'\n", row[0]);

    sprintf (query, match_history_query, row[0], row[0]);
    mysql_free_result (result);

    if (mysql_query (connection, query) != 0){
        error_fatal ("Error in query %s\n", mysql_error (connection));
    }
    result = mysql_use_result (connection);
    print_result(result, 0);
    mysql_free_result (result);
}

void delete_item(MYSQL *connection)
{
    char query[QUERY_SIZE];
    char bufferName[BUFFER_SIZE];
    printf("Enter item name to be deleted:\n");
    scanf("%s", bufferName);

    sprintf (query, delete_item_query, bufferName);

    if (mysql_query (connection, query) != 0){
        error_fatal ("Error in query %s\n", mysql_error (connection));
    }

    printf("Successfully deleted an item!\n");
}

void insert_new_item(MYSQL *connection)
{
    char query[QUERY_SIZE];
    char bufferName[BUFFER_SIZE];
    printf("Inserting a new item:\n");
    printf("Enter item name:\n");
    scanf("%s", bufferName);
    printf("Enter item cost:\n");
    int cost;
    scanf("%d", &cost);
    printf("Enter item health:\n");
    int health;
    scanf("%d", &health);
    printf("Enter item defense:\n");
    int defense;
    scanf("%d", &defense);
    printf("Enter item damage:\n");
    int damage;
    scanf("%d", &damage);
    printf("Enter item mana:\n");
    int mana;
    scanf("%d", &mana);
    printf("Enter item speed:\n");
    int speed;
    scanf("%d", &speed);

    sprintf (query, insert_item_query, bufferName, cost, health, defense,
        damage, mana, speed);

    if (mysql_query (connection, query) != 0){
        error_fatal ("Error in query %s\n", mysql_error (connection));
    }

    printf("Successfully entered a new item!\n");
}

void insert_new_match(MYSQL *connection)
{
    MYSQL_RES *result;
    MYSQL_ROW row;
    // MYSQL_FIELD *field;
    char query[QUERY_SIZE];
    char bufferName[BUFFER_SIZE];
    printf("Simulating a random match:\n");
    printf("Enter your account name\n");
    scanf("%s", bufferName);

    sprintf (query, "select id from player where name = '%s'", bufferName);

    if (mysql_query (connection, query) != 0){
        error_fatal ("Error in query %s\n", mysql_error (connection));
    }
    result = mysql_use_result (connection);

    row = mysql_fetch_row(result);
    if (row == 0){
        printf("Wrong username\n");
        return;
    }
    int id = atoi(row[0]);

    mysql_free_result (result);
    if (mysql_query (connection, "select count(*) from player") != 0){
        error_fatal ("Error in query %s\n", mysql_error (connection));
    }
    result = mysql_use_result (connection);
    row = mysql_fetch_row(result);
    int n = atoi(row[0]);
    mysql_free_result (result);
    int *players = malloc(sizeof(int) * n);
    for (int i=0; i<n; i++){
        players[i] = i + 1;
    }
    shuffle(players, n);
    // Zelim da izaberem 9  igraca pored unesenog.
    // promesam niz njih i uzimam prvih 9, i gledam da to ne bude uneseni igrac.
    for (int i=0; i<9; i++){
        if (players[i] == id){
            players[i] = players[n-1];
            break;
        }
    }

    int winner = rand() % 2;
    sprintf(query, insert_match_query, winner, id, players[0], players[1], players[2],
         players[3], players[4], players[5], players[6], players[7], players[8]);
    if (mysql_query (connection, query) != 0){
        error_fatal ("Error in query %s\n", mysql_error (connection));
    }
    if (winner){
        printf("Victory! :D\n");
    } else {
        printf("Defeat :( \n)");
    }
}

void change_password(MYSQL *connection)
{
    MYSQL_RES *result;
    MYSQL_ROW row;
    // MYSQL_FIELD *field;
    char query[QUERY_SIZE];
    char bufferName[BUFFER_SIZE];
    char bufferPass[BUFFER_SIZE];
    printf("Changing password:\n");
    printf("Enter your account name\n");
    scanf("%s", bufferName);
    printf("Enter your old password\n");
    scanf("%s", bufferPass);

    sprintf (query, "select * from player where name = '%s' and password = MD5('%s')", bufferName, bufferPass);

    if (mysql_query (connection, query) != 0){
        error_fatal ("Error in query %s\n", mysql_error (connection));
    }
    result = mysql_use_result (connection);

    // int num_fields = mysql_num_fields(result);
    row = mysql_fetch_row(result);
    if (row == 0){
        printf("Wrong username or pass\n");
        return;
    }
    // while( NULL != (field = mysql_fetch_field(result))){
    //   printf("%s\t|", field->name);
    // }
    // printf("\n");
    // unsigned long *lengths = mysql_fetch_lengths(result);
    // for (int i=0; i<num_fields; i++){
    //     printf ("%.*s\t|", (int)lengths[i], row[i] ? row[i] : "NULL");
    // }
    // printf("\n");
    printf("Chose a new password\n");
    scanf("%s", bufferPass);
    mysql_free_result (result);

    sprintf(query, "update player set password = '%s' where name = '%s'", bufferPass, bufferName);
    if (mysql_query (connection, query) != 0){
        error_fatal ("Error in query %s\n", mysql_error (connection));
    }

    if (mysql_affected_rows(connection) == 0){
        printf("Failed to change password.\n");
    } else {
        printf("Password changed successfully.\n");
    }
}

void select_all_from_player(MYSQL *connection)
{
    MYSQL_RES *result;
    char query[QUERY_SIZE];
    sprintf (query, "select * from player");

    /* Pokusava se sa izvrsavanjem upita. */
    if (mysql_query (connection, query) != 0)
        error_fatal ("Error in query %s\n", mysql_error (connection));

    /* Preuzima se result. */
    result = mysql_use_result (connection);
    print_result(result, 0);
    mysql_free_result (result);
}

void shuffle(int *array, size_t n)
{
    if (n > 1)
    {
        size_t i;
        for (i = 0; i < n - 1; i++)
        {
          size_t j = i + rand() / (RAND_MAX / (n - i) + 1);
          int t = array[j];
          array[j] = array[i];
          array[i] = t;
        }
    }
}


static void error_fatal (char *format, ...)
{
  va_list arguments;		/* Lista argumenata funkcije. */

  /* Stampa se string prowstavljen argumentima funkcije. */
  va_start (arguments, format);
  vfprintf (stderr, format, arguments);
  va_end (arguments);

  /* Prekida se program. */
  exit (EXIT_FAILURE);
}
