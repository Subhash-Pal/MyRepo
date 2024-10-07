# qt-translation-example

- Use menu to switch between German and English.
- Tested on macOS and Android using Qt 5.9.4 LTS

Based on this example:
* https://wiki.qt.io/How_to_create_a_multi_language_application

## Working with Qt Translation

- For all displayed and printed string literals in you app use ````tr()````.
- The Qt lupdate will serach your project for all ````tr()```` and create *.ts files.
    - For example: 
        - ````tr("Hello %1 !").arg(nameFirst)````
    - http://doc.qt.io/qt-5/i18n-source-translation.html

1) Add languages you wish to support to your Qt project file (*.pro) and run qmake again
````
TRANSLATIONS += \
    languages/TranslationExample_en.ts  \
    languages/TranslationExample_de.ts
````

2) Use Qt lupdate to auto-generate your inital ts files.
   - From Qt Creator menu select:
       - Tools > External > Linguist > Update Translations (lupdate)

3) For each ````<message>```` found in each TSL file translate the ````<source>```` text and paste into ````<translation>````
    - Manually change ````translation/@type```` attribute from "unfinished" to "finished".
    - Or delete ````translation/@type```` attribute after translation.  
    - When you run lupdate again, it will removed all ````translation/@type=finished```` attributes
        - Missing type attribute is same as "finished"
        - Y
    - For small one-by-word projects, use free web browser Google Transalte.
        - https://translate.google.com/?
    - I made this node.js script that requires a commercial Google Trnaslate API key:
        - https://github.com/esutton/i18n-translate-qt-ts

4) Use Qt lrelease to generate compressed *.qm files from translated *.ts files
    - From Qt Creator menu select:
        - Tools > External > Linguist > Release Translations (lrelease)

5) Copy *.qm files to the embedded resource folder ./res/translation
   - ToDo: Add code to *.pro file to copy *.qm to ./res/translation

## Automated Translation Using Google Translate
### [i18n-translate-qt-ts](https://github.com/esutton/i18n-translate-qt-ts)


I created this [i18n-translate-qt-ts](https://github.com/esutton/i18n-translate-qt-ts) as a node.js command line utility.

Use requires a commercial Google Translate API key:
- https://github.com/esutton/i18n-translate-qt-ts

To add translations to all ./languages/*.ts files in the [qt-translation-example](https://github.com/esutton/qt-translation-example) project:
````
# Use environment variable to store your API key
export API_KEY=AIzy0Vj...AIzy0VjQ
node index.js ${API_KEY} languages en
````

- If errors occur, you may need to run multiple times until all strings have translations.
    - Perhaps throttling the API calls might help this.
- If needed, send auto-translations to a native speaker for improvements.
    - [i18n-translate-qt-ts](https://github.com/esutton/i18n-translate-qt-ts) will not update 
    a manual translation unless ````translation/@type=unfinished```` 
    or source string is non-empty and ````<translation>```` is empty.
