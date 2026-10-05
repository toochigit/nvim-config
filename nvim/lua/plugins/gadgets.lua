return {
  -- Curseur avec une traînée animée quand il saute
  { "sphamba/smear-cursor.nvim", event = "VeryLazy", opts = {} },

  -- Affiche les mouvements Vim possibles sur la ligne (pour progresser)
  { "tris203/precognition.nvim", event = "VeryLazy", opts = {} },

  -- Te bloque quand tu spammes hjkl / les flèches (:Hardtime toggle pour couper)
  {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },

  -- Nom du fichier flottant en haut de chaque split
  { "b0o/incline.nvim", event = "VeryLazy", opts = {} },

  -- Mini-jeux pour s'entraîner aux motions : :VimBeGood
  { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },

  -- Ton code s'effondre ou prend feu
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = {
      { "<leader>mr", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Make it rain" },
      { "<leader>mg", "<cmd>CellularAutomaton game_of_life<cr>", desc = "Game of life" },
    },
  },

  -- Étoiles / neige / feuilles qui tombent sur l'écran d'accueil
  {
    "folke/drop.nvim",
    event = "VimEnter",
    opts = { theme = "stars" }, -- "snow", "leaves", "xmas", "spring", "summer"
  },

  -- Un canard qui se balade dans l'éditeur
  {
    "tamton-aquib/duck.nvim",
    keys = {
      { "<leader>dd", function() require("duck").hatch("🦆", 5) end, desc = "Hatch duck" },
      { "<leader>dk", function() require("duck").cook() end, desc = "Cook duck" },
    },
  },

  -- Ton activité affichée dans ton statut Discord
  { "andweeb/presence.nvim", event = "VeryLazy" },
}
