class GeneralConfig { //TODO copiar do servertest.ini
  //controllers

  bool serverHasInstalled = false;

  double ramDedicated = 6;

  //server-configs

  /// Players can hurt and kill other players
  bool pvp = true;

  ///Game time stops when there are no players online
  bool pauseEmpty = true;

  /// Toggles global chat on or off.
  bool globalChat = true;

  ///
  List chatStreams = ["s", "r", "a", "w", "y", "sh", "f", "all"];

  /// Clients may join without already having an account in the whitelist. If set to false, administrators must manually create username/password combos.
  bool open = true;

  /// The first welcome message visible in the chat panel. This will be displayed immediately after player login. you can use RGB colours to chance the colour of the welcome message. You can also use <LINE> to create a separate lines within
  String serverWelcomeMessage =
      "Welcome to Project Zomboid Multiplayer! <LINE> <LINE> To interact with the Chat panel: press Tab, T, or Enter. <LINE> <LINE> The Tab key will change the target stream of the message. <LINE> <LINE> Global Streams: /all <LINE> Local Streams: /say, /yell <LINE> Special Steams: /whisper, /safehouse, /faction. <LINE> <LINE> Press the Up arrow to cycle through your message history. Click the Gear icon to customize chat. <LINE> <LINE> Happy surviving!";

  /// Add unknown usernames to the whitelist when players join. Clients will supply their own username/password on joining. (This is for Open=true servers)
  bool autoCreateUserInWhiteList = true;

  /// Display usernames above player's heads in-game.
  bool displayUserName = true;

  /// Display first & last name above player's heads.
  bool showFirstAndLastName = false;

  /// Force every new player to spawn at these set x,y,z world coordinates. Find desired coordinates at map.projectzomboid.com. (Ignored when 0,0,0)
  ZomboidCoordinates spawnPoint = ZomboidCoordinates();

  /// Players can enter and leave PVP on an individual basis. A player can only hurt another player when at least one of them is in PVP mode - as shown by the unobscured skull and crossbones on the left of the screen. When SafetySystem=false, players are free to hurt each other at any time if PVP is enabled.
  bool safetySystem = true;

  /// Display a skull icon over the head of players who have entered PVP mode
  bool showSafety = true;

  /// The time it takes for a player to enter and leave PVP mode
  int safetyToggleTimer = 2;

  /// The delay before a player can enter or leave PVP mode again, having recently done so
  int safetyCooldownTimer = 3;

  /// Item types new players spawn with.\nSeparate multiple item types with commas.\nExample: Base.Axe,Base.Bag_BigHikingBag
  List spawnItems = [];

  /// Default starting port for player data. If UDP, this is this one of two ports used.
  int defaultPort = 16261;

  ///Reset ID determines if the server has undergone a soft-reset. If this number does match the client, the client must create a new character. Used in conjunction with PlayerServerID. It is strongly advised that you backup these IDs somewhere
  int resetID = 4090325;

  /// Enter the mod loading ID here. It can be found in \Steam\steamapps\workshop\modID\mods\modName\info.txt
  List mods = [];

  /// Enter the foldername of the mod found in \Steam\steamapps\workshop\modID\mods\modName\media\maps\
  String map = "Muldraugh, KY";

  /// Kick clients whose game files don't match the server's.
  bool doLuaChecksum = true;

  bool denyLoginOnOverloadedServer = true;

  /// Shows the server on the in-game browser. (Note: Steam-enabled servers are always visible in the Steam server browser)
  bool public = false;

  /// Name of the server displayed in the in-game browser and, if applicable, the Steam browser
  String publicName = "My PZ Server";

  /// Description displayed in the in-game public server browser. Typing \n will create a new line in your description
  String publicDescription = "";

  /// Maximum number of players that can be on the server at one time. This excludes admins.
  /// WARNING: Server player counts above 32 will potentially result in poor map streaming and desync. Please advance with caution.
  int maxPlayers = 32;

  /// Ping limit, in milliseconds, before a player is kicked from the server. (Set to 100 to disable)
  int pingLimit = 400;

  /// After X hours, all containers in the world will respawn loot. To spawn loot a container must have been looted at least once. Loot respawn is not impacted by visibility or subsequent looting.
  int hoursForLootRespawn = 0;


}

class ZomboidCoordinates {
  int x;
  int y;
  int z;

  ZomboidCoordinates({
    this.x = 0,
    this.y = 0,
    this.z = 0,
  });
}
