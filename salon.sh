#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"
SERVICE_1=$($PSQL "SELECT name FROM services WHERE service_id=1" | sed -E 's/^ *| *$//')
SERVICE_2=$($PSQL "SELECT name FROM services WHERE service_id=2" | sed -E 's/^ *| *$//')
SERVICE_3=$($PSQL "SELECT name FROM services WHERE service_id=3" | sed -E 's/^ *| *$//')
MAIN_MENU(){
  echo -e "\n~~~~~ SALON Dev Test 3/5 ~~~~~"
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  echo -e "\nHello, what service want to hire today?"
  echo -e "\n1) $SERVICE_1\n2) $SERVICE_2\n3) $SERVICE_3"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    1) MENU_1 ;;
    2) MENU_2 ;;
    3) MENU_3 ;;
    *) MAIN_MENU "The service that you pick isn't available or don't exist. Sorry." ;;
  esac
}
MENU_1(){
  echo -e "\nCleaning Service. What is your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'" | sed -E 's/^ *| *$//')
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nWe don't have you registered, can you enter your name?"
    read CUSTOMER_NAME
    RESULT_INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  SERVICE_ID=1
  echo -e "\nWhat time would you like to get the cleaning service?"
  read SERVICE_TIME
  RESULT_INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID,$SERVICE_ID,'$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERVICE_1 at $SERVICE_TIME, $CUSTOMER_NAME.\n"
}
MENU_2(){
  echo -e "\nCooking Service. What is your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'" | sed -E 's/^ *| *$//')
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nWe don't have you registered, can you enter your name?"
    read CUSTOMER_NAME
    RESULT_INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  SERVICE_ID=2
  echo -e "\nWhat time would you like to get the cooking service?"
  read SERVICE_TIME
  RESULT_INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID,$SERVICE_ID,'$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERVICE_2 at $SERVICE_TIME, $CUSTOMER_NAME.\n"
}
MENU_3(){
  echo -e "\nMusic Service. What is your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'" | sed -E 's/^ *| *$//')
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nWe don't have you registered, can you enter your name?"
    read CUSTOMER_NAME
    RESULT_INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  SERVICE_ID=3
  echo -e "\nWhat time would you like to get the music service?"
  read SERVICE_TIME
  RESULT_INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID,$SERVICE_ID,'$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERVICE_3 at $SERVICE_TIME, $CUSTOMER_NAME.\n"
}
EXIT(){
  echo -e "\nThanks for visiting our site to hire a service at our Salon.\n"
}

MAIN_MENU
