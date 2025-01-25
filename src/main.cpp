#include <Arduino.h>
#include "Preferences.h"
#define LED 2
#define PREFERENCES_READ_ONLY (true)
#define PREFERENCES_READ_WRITE (false)

Preferences preferences;
bool status = false;
void setup()
{
    Serial.begin(115200);
    pinMode(LED, OUTPUT);
    preferences.begin("test", PREFERENCES_READ_WRITE);
    if (preferences.isKey("status"))
    {
        Serial.println("Status found");
    }
    else
    {
        Serial.println("Status NOT found");
    }
    status = preferences.getBool("status", false);
    preferences.end();
    Serial.print("Retrieved status: ");
    Serial.println(status);
    Serial.println("--------------------");
    delay(2000);
}

void toggleStatus()
{
    status = !status;
    Serial.print("Status = ");
    Serial.println(status);
    digitalWrite(LED, status);
    preferences.begin("test", PREFERENCES_READ_WRITE);
    if (preferences.putBool("status", status))
    {
        Serial.print("Status saved as ");
        Serial.println(status);
    }
    else
    {
        Serial.println("Failed to save status");
    }
    preferences.end();
}

void loop()
{
    toggleStatus();
    delay(1000);
}
