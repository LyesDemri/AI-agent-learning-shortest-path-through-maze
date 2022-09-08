# AI-agent-learning-shortest-path-through-maze

This is a very basic example of Reinforcement Learning. I wrote it after reading [this](https://www.mathworks.com/content/dam/mathworks/ebook/gated/reinforcement-learning-ebook-all-chapters.pdf). The .m files contain: <br/>
*MazeExplorer.m is a simple game where the user must find his/her way out of a very simple maze using the WASD keys <br/>
*RandomMazeExplorer.m shows an agent learning to find its way through the same maze. <br/>
*MazeExplorerKey.m is the same game as MazeExplorer except you have to find a key before heading towards the exit <br/>
*RandomMazeExplorerKey.m shows an agent trying to learn to find the key first before heading towards the exit. The agent fails to do so because it isn't even aware of having the key <br/>
*RandomMazeExplorerKeyAware.m shows an agent learning to find a key before heading towards the exit. The agent is now aware of the existence of the key.<br/>
