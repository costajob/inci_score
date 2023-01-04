# frozen_string_literal: true

module Stubs
  CATALOG = {
      "generic-hazard"=>3,
      "parfum"=>0,
      "bha"=>4,
      "alanine"=>0,
      "allantoin"=>0,
      "aqua"=>0,
      "ci 61570"=>3,
      "ci 77491"=>0,
      "ci 77492"=>1,
      "cocamidopropyl betaine"=>1,
      "disodium cocoamphodiacetate"=>0,
      "disodium laureth sulfosuccinate"=>2,
      "glyceryl laurate"=>0,
      "glycine"=>0,
      "leucine"=>0,
      "lysine"=>0,
      "magnesium aspartate"=>0,
      "niacinamide"=>0,
      "peg-120 methyl glucose dioleate"=>3,
      "peg-150 distearate"=>3,
      "peg-7 glyceryl cocoate"=>3,
      "phenoxyethanol"=>2,
      "sodium lactate"=>0,
      "paraffinum liquidum"=>3,
      "ci 47005"=>3,
      "olea europea"=>0,
      "capryl glycol"=>2,
      "caprylic/capric triglyceride"=>0,
      "betula alba leaf water"=>1,
      "connective tissue extract"=>4,
      "dmhf"=>3,
      "acrylamide/sodium acrylate copolymer"=>3
  }.freeze

  DISTANCES = [
    ['', '', 0],
    ['elvis', '', 5],
    ['', 'elvis', 5],
    ['elvis', 'elvis', 0],
    ['elvis', 'ELVIS', 0],
    ['elvis', 'elviz', 1],
    ['king', 'the king', 4],
    ['graceland', 'disneyland', 5],
    ["föo", 'foo', 1],
    ["français", "francais", 1],
    ["français", "franæais", 1],
    ["私の名前はポールです", "ぼくの名前はポールです", 2],
    ["elvis\n", 'elvis', 1],
    ["\rking\n", "\nking", 2],
    ['teddybear', "\t\tteddybear\n", 3]
  ].freeze

  SOURCES = [
    "Ingredients: Aqua, Disodium Laureth Sulfosuccinate, Cocamidopropiyl\nBetaine, Disodium Cocoamphodiacetate, Giyceryi Laurate, PEGJ\nGlyceryi Cocoate, Sodium Lactate, Parfum,\n\nNiacinamide, Glycine, Magnesium Aspanate,\n\nAianine, Lysine, Leucine,A||antoin, PEG-150 E‘—\n\nDistearate, PEG-120 Methyl Glucose Dioleate, \n\nPhenoxyethanoi, CI 61570. 50\n\n \n\n",
    "\n\nDIENTS: Aqua, Sodium Laureth Sulfate, Sodium Chlor .\ngﬂfamine, Selaginella Lepidophylla Aerial Extract,PruI|:1es'§:::m\n0.11050“, Irehalose, Gluconolaaone, Glycenn, Guar Hydmyp«mylmmwmu:n\nChloride, Dimethiconol, Parfum, TEA-Dodetylbenzenesulfonate, 015mm\nEDIA, Mica, Carbomer, PPS-12, Citric Acid, Sodium HydmxideJEMuHate,\n\nWnethanolamine, Sodium Benzoate, DMDM Hydantoin, Methykhlowiso-\nIhmzoh'none, Methylisothiazolinone, ButylphenyI Methylpmpionaumm\n(142051), CI 47005, CI 77891.\n\n",
    "1099488 B - INGREDIENTS : AOUA I WATER.\nSODIUM LAURETH SULFATE, COCO-BETAINE,\nSODIUM LAURYL SULFATE. SODIUM CHLORIDE.\nGLYCOL DISTEARATE, NIACINAMIDE,_ ALCOHOL\nDEI‘IAT., SACCHARUM OFFICINARUM’EXTRACT I\nSUGAR CANE EXTRACT, HYDROXYPROPXLGUAR\nHYDROXVPROPYLTRIMONIUM CHLORIDE. SODIUM\nHYDROXIDE, AMINOPROPYL TRIETHOXYSILANE,\nPOLYOUATERNIUM-SO. CAMELLIA SINENGIS\nLEAF EXTRACT, BENZYL ALCOHOL, LINALOOL,\nPUNICA GRANATUM EXTRACT, 2—OLEAMIDO-1,3-\nOCTADECANEDIOL, ACRYLATES COPOLYMER, PYRUS\nMALUS EXTRACT / APPLE FRUIT EXTRACT, PYRIDOXINE\nHCI. CITRIC ACID, METHYLCHLOROISOTHIAZOUNONE.\nMETHYLISOTHIAZOUNONE, CITRUS MEDICA UMONUM\nPEEL EXTRACT/ LEMON PEEL EXTRACT. HEXYLENE\n\nGLYCOL, HEXYL CINNAMAL, AMYL CINNAMAL.\n\nPARFUM / FRAGRANCE (FIL C1631 07/2).\n\n",
    "7023 10 - INGREDIENTS: CAPRYLIC/CAPRIC\nﬁlGLYCERIDE, ISOPROPYL PALMITATE, ISOPROPYL\nMYRISTATE, PARFUM / FRAGRANCE, BENZYL ALCOHOL.\nBENZY L SALICYLATE, COUMARIN. HEXYL CINNAMAL,\nLIMONENE, LINALOOL, OLEA\n\nEUROPAEA 0|L/ OLIVE FRUIT\nOIL, PENTAERYTHRITYL\nTETRA-DI-T-BUTYL\nHYDROXYHYDROCINNAMAIE.\n«11317540710.\n\n",
    "mom-mansmsms: AQUA/WATER, PETROLATUM, GLVCERIN, PARAFFINUM\nunumum MINERAL OIL. CETEARYL ALCOHOL, DIMETHICONE, Buwnomamtmﬁgﬁ‘\nUUERISHEA BUTTER. BENZYL ALCOHOL. BENZVL SALICVLATE, CAPRYLVGLVCERYL\nc1 15510/0RANGE 4, CI 47005/ACID YELLOW 3, COUMARILP‘JVE W M\nCiNNAMAL, LIMONENE, LINALOOL, OLEA EUROPAEA OIL I 0\n6-100 STEARATE, PENTAERYTHRITVL\nTVLH‘IDROXVHVDROCINNAMATE,\nSODIUM anaome, 31mm ACID, PARFUM/\n~ ammo/1).\n\n \n \n \n   \n\n",
    " \n    \n \n \n     \n      \n    \n\n \n \n   \n\nINGREDIENTszA'oLM- a; V\nETHYLHEXYL PALMITATE - BE -~ x\n\nNIUM CHLORIDE ' SIMMONDSIA CH1 ‘   ~ .‘\nROSPERMUM PARK\" BUTTER ' PARFUM ' BONED?“ ALM\n\n- SODIUM BENZOATE - PANTHENOL ~ GUAR HYDROXYPRUWL-\nTRIMONIUM CHLORIDE - PHOSPHOLlPlDS ‘ C\\TR\\C AC“) -\nGLYCINE SOJA OIL ‘ TOCOPHERYL ACETATE - GLYCOLPm\n\n' GLYCINE SOJA STEROLS ' TOCOPHEROL\n\n  \n\n",
    "11005140-INGREDIENTS:AOUA/WATER,CE[EARYLALCOHOL\nDISTEAROYLETHYL annoxvmvwomw\nMETHOSULFATE,OCTYLDODECANULJEAMAYS J\nSTARCH / CORN STARCH. NIACINAMIDE r\nTOMPHEROLSACCHARUMOFFIUNARUMRM f\n/SJJGARCANEEXTRACT,MN.PIGH|APUNICIFOUAI '\nACEHOLAFRUITEXTRACT,CAMEL|NASATNAO|L/ f\nCAMELINASATIVASEEDOILCAMELUASlNENSlS :\nEXTRACT/CAMELLIASINENSISLEAFEXTRACT, F\nBENZOICACID,LlNALOOL,CAPRYLYLGLYCOL, ,5\nCADRYUUCAPRICTRIGLVCERIDEEYRUSM I\nEXTRACT /APPLE FRUIT EXTRACT, wmnome J\nHcmnmcgﬁmCIIRUSMEDICALIMONUM ;\nPEEL EXTRACT / LEMON PEEL EXTRACT. j\nPRUNUSARMENIACAKERNELOIL/APRICOT\nxmaommanmmamm ;\nOIL / SUYBEAN OIL, PARFUM I Emacs. ;\n\n(FlL 04391213) /\n\n \n\n",
    "      \n   \n   \n        \n    \n      \n\nINGREDIENTS: Butane, Isobutane, Propane,\nAluminum Chlorohydrate, PPG-14 Butyl Ether,\nCyclopentasiloxane, Parfum, Disteardimonium\nHectonte, Helianthus Annuus Seed Oil, C12-15\n§kV‘B?”103te,Octyldodecanol, BHT,\nﬂah'conﬂ. Propylene Carbonate, PEG4.\nEsme, Citric Acid, AI ha-Isomethyl lonone,\n09W. Benzyl alicylate, ButylphenY'\na?p'9na|. CItraI, Geraniol, Hexyl\n'L'm0nene, Linalool.\n\n",
    "INGREDIENTS : AQUa (wa‘eﬂ'\nslearate, Propylene glycol, F588\ncapric triglyceride, COCOS can\" ‘Wcla\n(Coconul) oil, Isupropyl palmna‘eW’ 09M\nalcohol, Sorbitan palmitate, pom\n\n40, Parfum (Fragrance), DisodiUm E\nCarbomer. Limonene, cum BHr\nSodium hydroxide, cums glands.\n(Grapefruit) fruit extract, SodiUm\ndroacetate, Sodium methyl dehy‘\n\nSorbic acid, Tetrasodium Elm-A CI\n10316 (Ext Yellow 7)‘\n\n",
    "782208 5‘ » INGREDIEMS: AQUA/WATER ~ GLYCERIN ' DIMETHICONE ' ISOHEXADEUNE ' SILICA\n‘ HVDROXVEIHYIHPERAZINE ETHANE SULFONIC ACID ' ALCOHOL DENAT. ' WE SLY“,- '\nSVNTHETIC WAX ' CI 77163 I BISMUTH OXVCHLORIDE ' CI 77391 / TIIANIUM DIOXIDE ' SECALE\nCEREALE EXTRACT/ RYE SEED EXTRACT ' SODIUM ACRYLATES COPOLVMER ‘ SODIUM\nHVALURONATE ‘ PHENOXYETHANOL ‘ ADENDSINE ~ PEG-10 DIMETHICONE ‘ ETHYLHEXYL\nHYDROXVSTEARATE ' NYLON-12 ' DIMETHICONE/PEG-IO/IS CROSSPOLVMER -\nD|HETHICONE/POLVGLYCERIN-3 CROSSPOLYMER ' PENWLENE GLYCOL ‘ SYNTHEIIC\nFLUORPHLOGOPITE ' BENZVL SALICVLATE - BENZVL ALCOHOL ' LINALOOL ‘ BENZVL BENZOATE '\nCAPRVLIUCAPRIC TRIGLYCERIDE ' CAPRVLYL GLYCOI. ‘ DIPOTASSIUM GLVCVRRHIZATE ' ALPINIA\nGAUNGA LEAF EXTRACT ' DISTEARDIMDNIUN HECTDRITE ' DISOUIUM EDTA - CIIRONELLOL ‘\nPARFUH/ FRAGRANCE. (F.I.L 3166675”).\nIorl MermIzIonI su\n\nM399 V ,\nwww.lorealpans.nt\n\n \n\n \n\n"
  ].freeze

  SCORES = [79, 64, 72, 63, 61, 82, 75, 56, 75, 62].freeze

  STATUSES = [true, true, true, true, true, true, false, true, true, true].freeze

  INGREDIENTS = [
    ["aqua", "disodium laureth sulfosuccinate", "cocamidopropiyl betaine", "disodium cocoamphodiacetate", "giyceryi laurate", "pegj glyceryi cocoate", "sodium lactate", "parfum", "niacinamide", "glycine", "magnesium aspanate", "aianine", "lysine", "leucine", "allantoin", "peg-150 e- distearate", "peg-120 methyl glucose dioleate", "phenoxyethanoi", "ci 61570", "50"],
    ["aqua", "sodium laureth sulfate", "sodium chlor", "gfamine", "selaginella lepidophylla aerial extract", "pruil1esm 011050", "irehalose", "gluconolaaone", "glycenn", "guar hydmypmylmmwmun chloride", "dimethiconol", "parfum", "tea-dodetylbenzenesulfonate", "015mm edia", "mica", "carbomer", "pps-12", "citric acid", "sodium hydmxidejemuhate", "wnethanolamine", "sodium benzoate", "dmdm hydantoin", "methykhlowiso- ihmzohnone", "methylisothiazolinone", "butylphenyi methylpmpionaumm (142051)", "ci 47005", "ci 77891"],
    ["aoua/water", "sodium laureth sulfate", "coco-betaine", "sodium lauryl sulfate", "sodium chloride", "glycol distearate", "niacinamide", "alcohol deiiat", "saccharum officinarumextract/sugar cane extract", "hydroxypropxlguar hydroxvpropyltrimonium chloride", "sodium hydroxide", "aminopropyl triethoxysilane", "polyouaternium-so", "camellia sinengis leaf extract", "benzyl alcohol", "linalool", "punica granatum extract", "2-oleamido-1", "3- octadecanediol", "acrylates copolymer", "pyrus malus extract / apple fruit extract", "pyridoxine hci", "citric acid", "methylchloroisothiazounone", "methylisothiazounone", "citrus medica umonum peel extract/ lemon peel extract", "hexylene glycol", "hexyl cinnamal", "amyl cinnamal", "parfum / fragrance (fil c1631 07/2)"],
    ["caprylic/capric lglyceride", "isopropyl palmitate", "isopropyl myristate", "parfum / fragrance", "benzyl alcohol", "benzy l salicylate", "coumarin", "hexyl cinnamal", "limonene", "linalool", "olea europaea 0ll/ olive fruit oil", "pentaerythrityl tetra-di-t-butyl hydroxyhydrocinnamaie", "11317540710"],
    ["aqua/water", "petrolatum", "glvcerin", "paraffinum unumum mineral oil", "cetearyl alcohol", "dimethicone", "buwnomamtmg uuerishea butter", "benzyl alcohol", "benzvl salicvlate", "caprylvglvceryl c1 15510/0range 4", "ci 47005/acid yellow 3", "coumarilpjve w m cinnamal", "limonene", "linalool", "olea europaea oil/0 6-100 stearate", "pentaerythritvl tvlhidroxvhvdrocinnamate", "sodium anaome", "31mm acid", "parfum/", "ammo/1)"],
    ["ingredientszaolm- a", "v ethylhexyl palmitate", "be -- x nium chloride", "simmondsia ch1", " rospermum park butter", "parfum", "boned alm", "sodium benzoate", "panthenol", "guar hydroxypruwl- trimonium chloride", "phosphollplds", "ctrc ac)", "glycine soja oil", "tocopheryl acetate", "glycolpm", "glycine soja sterols", "tocopherol"],
    ["aoua/water", "ce[earylalcohol distearoylethyl annoxvmvwomw methosulfate", "octyldodecanuljeamays j starch / corn starch", "niacinamide r tompherolsaccharumoffiunarumrm f /sjjgarcaneextract", "mnpighlapunicifouai", "aceholafruitextract", "camellnasatnaoll/ f camelinasativaseedoilcameluaslnensls", "extract/camelliasinensisleafextract", "f benzoicacid", "llnalool", "caprylylglycol", "5 cadryuucaprictriglvcerideeyrusm/extract /apple fruit extract", "wmnome j hcmnmcgmciirusmedicalimonum", "peel extract / lemon peel extract", "j prunusarmeniacakerneloil/apricot xmaommanmmamm", "oil / suybean oil", "parfum/emacs", "(fll 04391213) /"],
    ["butane", "isobutane", "propane", "aluminum chlorohydrate", "ppg-14 butyl ether", "cyclopentasiloxane", "parfum", "disteardimonium hectonte", "helianthus annuus seed oil", "c12-15 kvb103te", "octyldodecanol", "bht", "ahcon", "propylene carbonate", "peg4", "esme", "citric acid", "ai ha-isomethyl lonone", "09w", "benzyl alicylate", "butylpheny ap9nal", "citrai", "geraniol", "hexyl lm0nene", "linalool"],
    ["aqua (wae slearate", "propylene glycol", "f588 capric triglyceride", "cocos can wcla (coconul) oil", "isupropyl palmnaew 09m alcohol", "sorbitan palmitate", "pom 40", "parfum (fragrance)", "disodium e carbomer", "limonene", "cum bhr sodium hydroxide", "cums glands", "(grapefruit) fruit extract", "sodium droacetate", "sodium methyl dehy sorbic acid", "tetrasodium elm-a ci 10316 (ext yellow 7)"],
    ["aqua/water", "glycerin", "dimethicone", "isohexadeune", "silica", "hvdroxveihyihperazine ethane sulfonic acid", "alcohol denat", " we sly", "-", "svnthetic wax", "ci 77163/bismuth oxvchloride", "ci 77391 / tiianium dioxide", "secale cereale extract/ rye seed extract", "sodium acrylates copolvmer", "sodium hvaluronate", "phenoxyethanol", "adendsine", "peg-10 dimethicone", "ethylhexyl hydroxvstearate", "nylon-12", "dimethicone/peg-io/is crosspolvmer", "dlhethicone/polvglycerin-3 crosspolymer", "penwlene glycol", "syntheiic fluorphlogopite", "benzvl salicvlate", "benzvl alcohol", "linalool", "benzvl benzoate", "caprvliucapric triglyceride", "caprvlyl glycoi", " dipotassium glvcvrrhizate", "alpinia gaunga leaf extract", "disteardimdniun hectdrite", "disouium edta", "ciironellol", "parfuh/ fragrance", "(fil 3166675)", "iorl mermizioni su m399 v", "wwwlorealpansnt"]
  ].freeze

  COMPONENTS = [
    ["ci 61570", "ci 61570"],
    ["agua", "aqua"],
    ["olea europaea oil", "olea europea"],
    ["f588 capric triglyceride", "caprylic/capric triglyceride"]
  ].freeze

  HAZARDS = [
    [[], 0],
    [[0,1], 91],
    [[1,0], 87],
    [Array.new(10) { 4 }, 0],
    [Array.new(10) { 3 }, 25],
    [Array.new(10) { 2 }, 50],
    [Array.new(10) { 1 }, 75],
    [Array.new(10) { 0 }, 100],
    [[4,3,4,4,1,1,0], 46],
    [[0,1,0,0,2,3,0,4], 74],
    [[2,4,3,0,0,0,0,4], 63],
    [[1,0,0,1,0,2,0,4,3], 75],
    [[0,0,0,0,0,0,0,4], 89],
    [[4,4,4,4,4,4,4,0], 20],
    [[0,1,2,3,4] * 10, 61],
    [[0,1,2,3,4] * 100, 63]
  ].freeze
end
