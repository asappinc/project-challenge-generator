# ASAPP Project Challenge Generator

**Welcome to the project challenge!**

For this challenge, we ask that you implement a solution at home in your own time. When you're ready, please send us your results - including code, commit history if available, and a readme with setup instructions.


## Using the Project Generator

To start the project challenge generator, type:

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ASAPPinc/project-challenge-generator/master/install.sh)"
```

## The Details

Your challenge is to build a split screen chat interface. In one browser tab, there should be two side-by-side chat windows. On the left is Laura's chat window and she's talking to Rob. On the right is Rob's chat window and he's talking to Laura.

In her window, Laura is able to type and send a message to Rob. The message should appear as a sent message in her window and as a received message in his window. Additionally, when Laura is in the middle of typing, there should be an indicator in Rob's window that she's typing. And all this should work in the other direction for Rob sending a message to Laura.

This challenge is contained to one browser tab, but in real life, Laura and Rob would be on different devices and messages would be sent over a central server. Building a server isn’t part of this challenge, but we ask that you structure your code in such a way that it’d be straightforward to get rid of the split screen and plug in a server to support real remote chatting.
