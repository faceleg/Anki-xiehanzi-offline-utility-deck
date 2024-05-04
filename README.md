
# Anki xiehanzi Offline Utility Deck

This repository aims to semi-automate the creation of an Anki deck that includes all the necessary data files for xiehanzi to function fully offline. The utility is designed to enhance the use of xiehanzi, a tool for learning Chinese characters interactively within Anki.

## Overview

The xiehanzi tool (found [here](https://krmanik.github.io/Anki-xiehanzi/)) requires specific data files to work offline. This repository provides scripts to automate the generation of a TSV deck file containing these data files, making it easy to setup and use xiehanzi offline in Anki.

## Repository Contents

- **generate-deck-tsv.sh**: A shell script to download the necessary JSON data, process it, and compile it into a TSV file stored in a 'data' directory.
- **README.md**: This file, which provides documentation on how to use the scripts and resources provided.

## Prerequisites

- [Anki](https://apps.ankiweb.net/) installed on your computer.
- Access to a terminal or command line interface.

## Setup and Usage Instructions

### 1. Run the Script

Execute the script to generate the TSV file and download the JSON data:

```bash
./generate-deck-tsv.sh
```

This script will create a `data` directory containing the `xiehanzi_offline_data.tsv` file and a `json_files` directory with the necessary JSON files.

### 2. Copy JSON Files into Anki's Collection Media Folder

To ensure the xiehanzi tool functions correctly offline, copy the JSON files from the `json_files` directory to your Anki collection's media folder. You can find the location of this folder by following the instructions [here](https://docs.ankiweb.net/files.html#file-locations). This step is crucial for the proper functioning of the deck.

### 3. Import TSV File into Anki

Follow these steps to import the generated TSV file into Anki:

- Open Anki.
- Select `File > Import` from the menu.
- Choose the `xiehanzi_offline_data.tsv` file located in the `data` directory.
- Import this file into a new or existing deck as required.

### 4. Renaming the Deck (if necessary)

After importing, you may rename the deck to better reflect its purpose or to organize your study materials:

- Click on the deck name in Anki.
- Select `Rename` from the options.

### 5. Update Deck Settings

Since this deck is intended for utility purposes and not daily study, update the deck settings to set the daily new cards to 0 "for this deck only":

- Select the deck.
- Click on `Options`.
- Adjust `New Cards/Day` to `0` under `Daily Limits`, ensuring you select "for this deck only".

### 6. Further Configuration in Card Templates

Further work will be required in the card configuration to fully integrate the utility into your decks. Since deck setups can vary widely, direct instructions cannot be provided. However, here are two code snippets that may be relevant depending on your setup:

#### Code Snippet 1:
```html
<!-- Include xiehanzi.js -->
<script src="_xiehanzi.js"></script>
<div id="character-target-div"></div>
<script type="text/javascript">
  // Function to load character data from a given URL
  function loadDataFromUrl(url, onComplete) {
    var xhr = new XMLHttpRequest();

    xhr.open("GET", url, true);

    // Set up a callback function to handle the response
    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          // Parse the JSON response
          var charData = JSON.parse(xhr.responseText);
          onComplete(charData);
        } else {
          // Log an error message if the request fails
          printDebugMessage(
            "Request failed with status: " + xhr.status + " for URL: " + url,
          );
        }
      }
    };

    // Send the request
    xhr.send();
  }
  var writer = HanziWriter.create('character-target-div', '{{Character}}', {
    width: 200,
    height: 200,
    padding: 5,
    strokeAnimationSpeed: 1,
    delayBetweenStrokes: 200,
    showCharacter: false,
    /**
     * Try to load the character locally, fallback to the default location if that fails
     */ 
    charDataLoader: function (character, onComplete) {
        var initialUrl = "/_" + character + ".json";

        // Attempt to load character data from the initial URL
        loadDataFromUrl(
            initialUrl,
            function (charData) {
                onComplete(charData);
            },
            function () {
                // If the initial load fails, fallback to loading from another URL
                var fallbackUrl =
                    "https://cdn.jsdelivr.net/npm/hanzi-writer-data@2.0/" +
                    character +
                    ".json";
                loadDataFromUrl(fallbackUrl, function (charData) {
                    onComplete(charData);
                });
            },
        );
    }
  });
</script>
```

## Additional Resources

- **xiehanzi Tool**: [Anki xiehanzi](https://krmanik.github.io/Anki-xiehanzi/)
- **Hanzi Writer Project**: [Hanzi Writer](https://hanziwriter.org/), the open-source library used for rendering interactive Chinese character animations.

## Contributions

Contributions to this project are welcome! Please consider enhancing scripts, documentation, or adding new features to help improve the use of xiehanzi offline.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
