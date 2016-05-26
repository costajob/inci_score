require 'yaml'

module Stubs
  module Levenshtein
    extend self

    Stub = Struct::new(:s, :t, :distance)

    def strings
      [Stub::new('', '', 0),
       Stub::new('elvis', '', 5),
       Stub::new('', 'elvis', 5),
       Stub::new('elvis', 'elvis', 0),
       Stub::new('elvis', 'ELVIS', 0),
       Stub::new('elvis', 'elviz', 1),
       Stub::new('king', 'the king', 4),
       Stub::new('graceland', 'disneyland', 5)]
    end

    def utf8_strings
      [Stub::new("föo", 'foo', 1),
       Stub::new("français", "francais", 1),
       Stub::new("français", "franæais", 1),
       Stub::new("私の名前はポールです", "ぼくの名前はポールです", 2)]
    end

    def raw_strings
      [Stub::new("elvis\n", 'elvis', 1),
       Stub::new("\rking\n", "\nking", 2),
       Stub::new('teddybear', "\t\tteddybear\n", 3)]
    end
  end

  module Parser
    extend self

    def html
      %q{<html><body><table border="0" width="751" cellspacing="0"  align="center"><tr><td><font face="Verdana, Arial, Helvetica, sans-serif"><b><font color="#000000" size="4">Trovati 5034 risultati</font></b><br><br><img src=http://biodizionario.it/images/semafori/v.gif border=0 width=39 height=20>&nbsp;&nbsp;<b><font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 14px"> Emulsionante / Condizionante pelle</font></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 13px">PHOSPHATIDYLCHOLINE</font><br><img src=http://biodizionario.it/images/semafori/r.gif border=0 width=39 height=20>&nbsp;&nbsp;<b><font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 14px">1-NAPHTHOL</font></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 13px">colorante capelli</font><br><img src=http://biodizionario.it/images/semafori/r.gif border=0 width=39 height=20>&nbsp;&nbsp;<b><font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 14px">1,2,4-BENZENETRIACETATE </font></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 13px">colorante capelli </font><br><img src=http://biodizionario.it/images/semafori/vv.gif border=0 width=39 height=20>&nbsp;&nbsp;<b><font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 14px">1,3-BIS-(2,4-DIAMINOPHENOXY)PROPANE </font></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 13px">colorante capelli </font><br><img src=http://biodizionario.it/images/semafori/g.gif border=0 width=39 height=20>&nbsp;&nbsp;<b><font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 14px">ACETYLATED LANOLIN </font></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 13px">antistatico / emolliente / emulsionante </font><br><img src=http://biodizionario.it/images/semafori/rr.gif border=0 width=39 height=20>&nbsp;&nbsp;<b><font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 14px">1-NAPHTHOL</font></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 13px">colorante capelli</font><br><img src=http://biodizionario.it/images/semafori/g.gif border=0 width=39 height=20>&nbsp;&nbsp;<b><font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 14px">HEXYLDECYL LAURATE</font></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color=#550055 face="Verdana,Arial,helvetica,sans-serif" style="font-size: 13px"></font><br></td></tr></table></body></html>}
    end
  end

  module Normalizer
    extend self

    Stub = Struct::new(:src, :ingredients)

    def sources
      [Stub::new("Ingredients: Aqua, Disodium Laureth Sulfosuccinate, Cocamidopropiyl\nBetaine, Disodium Cocoamphodiacetate, Giyceryi Laurate, PEGJ\nGlyceryi Cocoate, Sodium Lactate, Parfum,\n\nNiacinamide, Glycine, Magnesium Aspanate,\n\nAianine, Lysine, Leucine,A||antoin, PEG-150 E‘—\n\nDistearate, PEG-120 Methyl Glucose Dioleate, ——\n\nPhenoxyethanoi, CI 61570. 50\n\n \n\n", ["aqua", "disodium laureth sulfosuccinate", "cocamidopropiyl betaine", "disodium cocoamphodiacetate", "giyceryi laurate", "pegj glyceryi cocoate", "sodium lactate", "parfum", "niacinamide", "glycine", "magnesium aspanate", "aianine", "lysine", "leucine", "allantoin", "peg150 e distearate", "peg120 methyl glucose dioleate", "phenoxyethanoi", "ci 61570", "50"]),
       Stub::new("\n\nDIENTS: Aqua, Sodium Laureth Sulfate, Sodium Chlor .\ngﬂfamine, Selaginella Lepidophylla Aerial Extract,PruI|:1es'§:::m\n0.11050“, Irehalose, Gluconolaaone, Glycenn, Guar Hydmyp«mylmmwmu:n\n(hloride, Dimethiconol, Parfum, TEA-Dodetylbenzenesulfonate, 015mm\nEDIA, Mica, (arbomer, PPS-12, (itric Acid, Sodium HydmxideJEMuHate,\n\nWnethanolamine, Sodium Benzoate, DMDM Hydantoin, Methykhlowiso-\nIhmzoh'none, Methylisothiazolinone, ButylphenyI Methylpmpionaumm\n(142051, (I 47005, (I 77891.\n\n", ["aqua", "sodium laureth sulfate", "sodium chlor", "gfamine", "selaginella lepidophylla aerial extract", "pruil1esm 011050", "irehalose", "gluconolaaone", "glycenn", "guar hydmypmylmmwmun chloride", "dimethiconol", "parfum", "teadodetylbenzenesulfonate", "015mm edia", "mica", "carbomer", "pps12", "citric acid", "sodium hydmxidejemuhate", "wnethanolamine", "sodium benzoate", "dmdm hydantoin", "methykhlowiso ihmzohnone", "methylisothiazolinone", "butylphenyi methylpmpionaumm c142051", "ci 47005", "ci 77891"]),
       Stub::new("1099488 B - INGREDIENTS : AOUA I WATER.\nSODIUM LAURETH SULFATE, COCO-BETAINE,\nSODIUM LAURYL SULFATE. SODIUM CHLORIDE.\nGLYCOL DISTEARATE, NIACINAMIDE,_ ALCOHOL\nDEI‘IAT., SACCHARUM OFFICINARUM’EXTRACT I\nSUGAR CANE EXTRACT, HYDROXYPROPXLGUAR\nHYDROXVPROPYLTRIMONIUM CHLORIDE. SODIUM\nHYDROXIDE, AMINOPROPYL TRIETHOXYSILANE,\nPOLYOUATERNIUM-SO. CAMELLIA SINENGIS\nLEAF EXTRACT, BENZYL ALCOHOL, LINALOOL,\nPUNICA GRANATUM EXTRACT, 2—OLEAMIDO-1,3-\nOCTADECANEDIOL, ACRYLATES COPOLYMER, PYRUS\nMALUS EXTRACT / APPLE FRUIT EXTRACT, PYRIDOXINE\nHCI. CITRIC ACID, METHYLCHLOROISOTHIAZOUNONE.\nMETHYLISOTHIAZOUNONE, CITRUS MEDICA UMONUM\nPEEL EXTRACT/ LEMON PEEL EXTRACT. HEXYLENE\n\nGLYCOL, HEXYL CINNAMAL, AMYL CINNAMAL.\n\nPARFUM / FRAGRANCE (FIL C1631 07/2).\n\n", ["aoua", "sodium laureth sulfate", "cocobetaine", "sodium lauryl sulfate", "sodium chloride", "glycol distearate", "niacinamide", "alcohol deiiat", "saccharum officinarumextract", "hydroxypropxlguar hydroxvpropyltrimonium chloride", "sodium hydroxide", "aminopropyl triethoxysilane", "polyouaterniumso", "camellia sinengis leaf extract", "benzyl alcohol", "linalool", "punica granatum extract", "2oleamido1", "3 octadecanediol", "acrylates copolymer", "pyrus malus extract", "pyridoxine hci", "citric acid", "methylchloroisothiazounone", "methylisothiazounone", "citrus medica umonum peel extract", "hexylene glycol", "hexyl cinnamal", "amyl cinnamal", "parfum"]),
       Stub::new("7023 10 - INGREDIENTS: CAPRYLIC/CAPRIC\nﬁlGLYCERIDE, ISOPROPYL PALMITATE, ISOPROPYL\nMYRISTATE, PARFUM / FRAGRANCE, BENZYL ALCOHOL.\nBENZY L SALICYLATE, COUMARIN. HEXYL CINNAMAL,\nLIMONENE, LINALOOL, OLEA\n\nEUROPAEA 0|L/ OLIVE FRUIT\nOIL, PENTAERYTHRITYL\nTETRA-DI-T-BUTYL\nHYDROXYHYDROCINNAMAIE.\n«11317540710.\n\n", ["caprylic", "isopropyl palmitate", "isopropyl myristate", "parfum", "benzyl alcohol", "benzy l salicylate", "coumarin", "hexyl cinnamal", "limonene", "linalool", "olea europaea 0ll", "pentaerythrityl tetraditbutyl hydroxyhydrocinnamaie", "11317540710"]),
       Stub::new("mom-mansmsms: AQUA/WATER, PETROLATUM, GLVCERIN, PARAFFINUM\nunumum MINERAL OIL. CETEARYL ALCOHOL, DIMETHICONE, Buwnomamtmﬁgﬁ‘\nUUERISHEA BUTTER. BENZYL ALCOHOL. BENZVL SALICVLATE, CAPRYLVGLVCERYL\nc1 15510/0RANGE 4, CI 47005/ACID YELLOW 3, COUMARILP‘JVE W M\nCiNNAMAL, LIMONENE, LINALOOL, OLEA EUROPAEA OIL I 0\n6-100 STEARATE, PENTAERYTHRITVL\nTVLH‘IDROXVHVDROCINNAMATE,\nSODIUM anaome, 31mm ACID, PARFUM/\n~ ammo/1).\n\n \n \n \n   \n\n", ["aqua", "petrolatum", "glvcerin", "paraffinum unumum mineral oil", "cetearyl alcohol", "dimethicone", "buwnomamtmg uuerishea butter", "benzyl alcohol", "benzvl salicvlate", "caprylvglvceryl c1 15510", "ci 47005", "coumarilpjve w m cinnamal", "limonene", "linalool", "olea europaea oil", "pentaerythritvl tvlhidroxvhvdrocinnamate", "sodium anaome", "31mm acid", "parfum", "ammo"]),
       Stub::new(" \n    \n \n \n     \n      \n    \n\n \n \n   \n\nINGREDIENTszA'oLM- a; V\nETHYLHEXYL PALMITATE - BE -~ x\n\nNIUM CHLORIDE ' SIMMONDSIA CH1 ‘   ~ .‘\nROSPERMUM PARK\" BUTTER ' PARFUM ' BONED?“ ALM\n\n- SODIUM BENZOATE - PANTHENOL ~ GUAR HYDROXYPRUWL-\nTRIMONIUM CHLORIDE - PHOSPHOLlPlDS ‘ C\\TR\\C AC“) -\nGLYCINE SOJA OIL ‘ TOCOPHERYL ACETATE - GLYCOLPm\n\n' GLYCINE SOJA STEROLS ' TOCOPHEROL\n\n  \n\n", ["ingredientszaolm a", "v ethylhexyl palmitate", "be x nium chloride", "simmondsia ch1", "rospermum park butter", "parfum", "boned alm", "sodium benzoate", "panthenol", "guar hydroxypruwl trimonium chloride", "phosphollplds", "ctrc ac", "glycine soja oil", "tocopheryl acetate", "glycolpm", "glycine soja sterols", "tocopherol"]),
       Stub::new("11005140-INGREDIENTS:AOUA/WATER,CE[EARYLALCOHOL\nDISTEAROYLETHYL annoxvmvwomw\nMETHOSULFATE,OCTYLDODECANULJEAMAYS J\nSTARCH / CORN STARCH. NIACINAMIDE r\nTOMPHEROLSACCHARUMOFFIUNARUMRM f\n/SJJGARCANEEXTRACT,MN.PIGH|APUNICIFOUAI '\nACEHOLAFRUITEXTRACT,CAMEL|NASATNAO|L/ f\nCAMELINASATIVASEEDOILCAMELUASlNENSlS :\nEXTRACT/CAMELLIASINENSISLEAFEXTRACT, F\nBENZOICACID,LlNALOOL,CAPRYLYLGLYCOL, ,5\nCADRYUUCAPRICTRIGLVCERIDEEYRUSM I\nEXTRACT /APPLE FRUIT EXTRACT, wmnome J\nHcmnmcgﬁmCIIRUSMEDICALIMONUM ;\nPEEL EXTRACT / LEMON PEEL EXTRACT. j\nPRUNUSARMENIACAKERNELOIL/APRICOT\nxmaommanmmamm ;\nOIL / SUYBEAN OIL, PARFUM I Emacs. ;\n\n(FlL 04391213) /\n\n \n\n", ["aoua", "ceearylalcohol distearoylethyl annoxvmvwomw methosulfate", "octyldodecanuljeamays j starch", "niacinamide r tompherolsaccharumoffiunarumrm f", "mnpighlapunicifouai", "aceholafruitextract", "camellnasatnaoll", "extract", "f benzoicacid", "llnalool", "caprylylglycol", "5 cadryuucaprictriglvcerideeyrusm", "wmnome j hcmnmcgmciirusmedicalimonum", "peel extract", "j prunusarmeniacakerneloil", "oil", "parfum", "cfll 04391213"]),
       Stub::new("      \n   \n   \n        \n    \n      \n\nINGREDIENTS: Butane, Isobutane, Propane,\nAluminum Chlorohydrate, PPG-14 Butyl Ether,\nCyclopentasiloxane, Parfum, Disteardimonium\nHectonte, Helianthus Annuus Seed Oil, C12-15\n§kV‘B?”103te,Octyldodecanol, BHT,\nﬂah'conﬂ. Propylene Carbonate, PEG4.\nEsme, Citric Acid, AI ha-Isomethyl lonone,\n09W. Benzyl alicylate, ButylphenY'\na?p'9na|. CItraI, Geraniol, Hexyl\n'L'm0nene, Linalool.\n\n", ["butane", "isobutane", "propane", "aluminum chlorohydrate", "ppg14 butyl ether", "cyclopentasiloxane", "parfum", "disteardimonium hectonte", "helianthus annuus seed oil", "c1215 kvb103te", "octyldodecanol", "bht", "ahcon", "propylene carbonate", "peg4", "esme", "citric acid", "ai haisomethyl lonone", "09w", "benzyl alicylate", "butylpheny ap9nal", "citrai", "geraniol", "hexyl lm0nene", "linalool"]),
       Stub::new("INGREDIENTS : AQUa (wa‘eﬂ'\nslearate, Propylene glycol, F588\ncapric triglyceride, COCOS can\" ‘Wcla\n(Coconul) oil, Isupropyl palmna‘eW’ 09M\nalcohol, Sorbitan palmitate, pom\n\n40, Parfum (Fragrance), DisodiUm E\nCarbomer. Limonene, cum BHr\nSodium hydroxide, cums glands.\n(Grapefruit) fruit extract, SodiUm\ndroacetate, Sodium methyl dehy‘\n\nSorbic acid, Tetrasodium Elm-A CI\n10316 (Ext Yellow 7)‘\n\n", ["aqua cwae slearate", "propylene glycol", "f588 capric triglyceride", "cocos can wcla ccoconul oil", "isupropyl palmnaew 09m alcohol", "sorbitan palmitate", "pom 40", "parfum cfragrance", "disodium e carbomer", "limonene", "cum bhr sodium hydroxide", "cums glands", "cgrapefruit fruit extract", "sodium droacetate", "sodium methyl dehy sorbic acid", "tetrasodium elma ci 10316 cext yellow 7"]),
       Stub::new("782208 5‘ » INGREDIEMS: AQUA/WATER ~ GLYCERIN ' DIMETHICONE ' ISOHEXADEUNE ' SILICA\n‘ HVDROXVEIHYIHPERAZINE ETHANE SULFONIC ACID ' ALCOHOL DENAT. ' WE SLY“,- '\nSVNTHETIC WAX ' CI 77163 I BISMUTH OXVCHLORIDE ' CI 77391 / TIIANIUM DIOXIDE ' SECALE\nCEREALE EXTRACT/ RYE SEED EXTRACT ' SODIUM ACRYLATES COPOLVMER ‘ SODIUM\nHVALURONATE ‘ PHENOXYETHANOL ‘ ADENDSINE ~ PEG-10 DIMETHICONE ‘ ETHYLHEXYL\nHYDROXVSTEARATE ' NYLON-12 ' DIMETHICONE/PEG-IO/IS CROSSPOLVMER -\nD|HETHICONE/POLVGLYCERIN-3 CROSSPOLYMER ' PENWLENE GLYCOL ‘ SYNTHEIIC\nFLUORPHLOGOPITE ' BENZVL SALICVLATE - BENZVL ALCOHOL ' LINALOOL ‘ BENZVL BENZOATE '\nCAPRVLIUCAPRIC TRIGLYCERIDE ' CAPRVLYL GLYCOI. ‘ DIPOTASSIUM GLVCVRRHIZATE ' ALPINIA\nGAUNGA LEAF EXTRACT ' DISTEARDIMDNIUN HECTDRITE ' DISOUIUM EDTA - CIIRONELLOL ‘\nPARFUH/ FRAGRANCE. (F.I.L 3166675”).\nIorl MermIzIonI su\n\nM399 V ,\nwww.lorealpans.nt\n\n \n\n \n\n", ["aqua", "glycerin", "dimethicone", "isohexadeune", "silica", "hvdroxveihyihperazine ethane sulfonic acid", "alcohol denat", "we sly", "svnthetic wax", "ci 77163", "ci 77391", "secale cereale extract", "sodium acrylates copolvmer", "sodium hvaluronate", "phenoxyethanol", "adendsine", "peg10 dimethicone", "ethylhexyl hydroxvstearate", "nylon12", "dimethicone", "dlhethicone", "penwlene glycol", "syntheiic fluorphlogopite", "benzvl salicvlate", "benzvl alcohol", "linalool", "benzvl benzoate", "caprvliucapric triglyceride", "caprvlyl glycoi", "dipotassium glvcvrrhizate", "alpinia gaunga leaf extract", "disteardimdniun hectdrite", "disouium edta", "ciironellol", "parfuh", "cfil 3166675", "iorl mermizioni su m399 v", "wwwlorealpansnt"])]
    end
  end

  module Computer
    extend self

    Stub = Struct::new(:name, :src)

    def ingredients
      "Ingredients: Aqua, Disodium Laureth Sulfosuccinate, Cocamidopropiyl\nBetaine, Disodium Cocoamphodiacetate, Giyceryi Laurate, PEGJ\nGlyceryi Cocoate, Sodium Lactate, Parfum,\n\nNiacinamide, Glycine, Magnesium Aspanate,\n\nAianine, Lysine, Leucine,A||antoin, PEG-150 E‘—\n\nDistearate, PEG-120 Methyl Glucose Dioleate, ——\n\nPhenoxyethanoi, CI 61570. 50\n\n \n\n"
    end

    def catalog
      {"parfum"=>0, "bha"=>4, "alanine"=>0, "allantoin"=>0, "aqua"=>0, "ci 61570"=>3, "cocamidopropyl betaine"=>1, "disodium cocoamphodiacetate"=>0, "disodium laureth sulfosuccinate"=>2, "glyceryl laurate"=>0, "glycine"=>0, "leucine"=>0, "lysine"=>0, "magnesium aspartate"=>0, "niacinamide"=>0, "peg-120 methyl glucose dioleate"=>3, "peg-150 distearate"=>3, "peg-7 glyceryl cocoate"=>3, "phenoxyethanol"=>2, "sodium lactate"=>0, "paraffinum liquidum"=>3, "ci 47005"=>3, "olea europea"=>0, "capryl glycol"=>2, "caprylic/capric triglyceride"=>0, "betula alba leaf water"=>1, "connective tissue extract"=>4, "dmhf"=>3, "acrylamide/sodium acrylate copolymer"=>3}
    end

    def sources
      [Stub::new("key", "aqua"),
       Stub::new("key,dist", "agua"),
       Stub::new("key,dist,digits", "olea europaea 1100"),
       Stub::new("all", "hexylene glycol")]
    end
  end

  module Scorer
    extend self

    Stub = Struct::new(:hazards, :score)

    def hazards
      [Stub::new([], 0),
       Stub::new([0,1], 91), 
       Stub::new([1,0], 87), 
       Stub::new(Array::new(10) { 4 }, 0),
       Stub::new(Array::new(10) { 3 }, 25),
       Stub::new(Array::new(10) { 2 }, 50),
       Stub::new(Array::new(10) { 1 }, 75),
       Stub::new(Array::new(10) { 0 }, 100),
       Stub::new([4,3,4,4,1,1,0], 46),
       Stub::new([0,1,0,0,2,3,0,4], 74),
       Stub::new([2,4,3,0,0,0,0,4], 63),
       Stub::new([1,0,0,1,0,2,0,4,3], 75),
       Stub::new([0,0,0,0,0,0,0,4], 89),
       Stub::new([4,4,4,4,4,4,4,0], 20),
       Stub::new([0,1,2,3,4] * 10, 61),
       Stub::new([0,1,2,3,4] * 100, 63)]
    end
  end

  module API
    extend self

    Stub = Struct::new(:score, :valid, :src)

    def sources
      [Stub::new(82, true, "Ingredients: Aqua, Disodium Laureth Sulfosuccinate, Cocamidopropiyl\nBetaine, Disodium Cocoamphodiacetate, Giyceryi Laurate, PEGJ\nGlyceryi Cocoate, Sodium Lactate, Parfum,\n\nNiacinamide, Glycine, Magnesium Aspanate,\n\nAianine, Lysine, Leucine,A||antoin, PEG-150 E‘—\n\nDistearate, PEG-120 Methyl Glucose Dioleate, ——\n\nPhenoxyethanoi, CI 61570. 50\n\n \n\n"),
       Stub::new(67, true, " \n\nDIENTS: Aqua, Sodium Laureth Sulfate, Sodium Chlor .\ngﬂfamine, Selaginella Lepidophylla Aerial Extract,PruI|:1es'§:::m\n0.11050“, Irehalose, Gluconolaaone, Glycenn, Guar Hydmyp«mylmmwmu:n\n(hloride, Dimethiconol, Parfum, TEA-Dodetylbenzenesulfonate, 015mm\nEDIA, Mica, (arbomer, PPS-12, (itric Acid, Sodium HydmxideJEMuHate,\n\nWnethanolamine, Sodium Benzoate, DMDM Hydantoin, Methykhlowiso-\nIhmzoh'none, Methylisothiazolinone, ButylphenyI Methylpmpionaumm\n(142051, (I 47005, (I 77891.\n\n"),
       Stub::new(70, true, "1099488 B - INGREDIENTS : AOUA I WATER.\nSODIUM LAURETH SULFATE, COCO-BETAINE,\nSODIUM LAURYL SULFATE. SODIUM CHLORIDE.\nGLYCOL DISTEARATE, NIACINAMIDE,_ ALCOHOL\nDEI‘IAT., SACCHARUM OFFICINARUM’EXTRACT I\nSUGAR CANE EXTRACT, HYDROXYPROPXLGUAR\nHYDROXVPROPYLTRIMONIUM CHLORIDE. SODIUM\nHYDROXIDE, AMINOPROPYL TRIETHOXYSILANE,\nPOLYOUATERNIUM-SO. CAMELLIA SINENGIS\nLEAF EXTRACT, BENZYL ALCOHOL, LINALOOL,\nPUNICA GRANATUM EXTRACT, 2—OLEAMIDO-1,3-\nOCTADECANEDIOL, ACRYLATES COPOLYMER, PYRUS\nMALUS EXTRACT / APPLE FRUIT EXTRACT, PYRIDOXINE\nHCI. CITRIC ACID, METHYLCHLOROISOTHIAZOUNONE.\nMETHYLISOTHIAZOUNONE, CITRUS MEDICA UMONUM\nPEEL EXTRACT/ LEMON PEEL EXTRACT. HEXYLENE\n\nGLYCOL, HEXYL CINNAMAL, AMYL CINNAMAL.\n\nPARFUM / FRAGRANCE (FIL C1631 07/2).\n\n"),
       Stub::new(71, true, "7023 10 - INGREDIENTS: CAPRYLIC/CAPRIC\nﬁlGLYCERIDE, ISOPROPYL PALMITATE, ISOPROPYL\nMYRISTATE, PARFUM / FRAGRANCE, BENZYL ALCOHOL.\nBENZY L SALICYLATE, COUMARIN. HEXYL CINNAMAL,\nLIMONENE, LINALOOL, OLEA\n\nEUROPAEA 0|L/ OLIVE FRUIT\nOIL, PENTAERYTHRITYL\nTETRA-DI-T-BUTYL\nHYDROXYHYDROCINNAMAIE.\n«11317540710.\n\n"),
       Stub::new(66, true, "mom-mansmsms: AQUA/WATER, PETROLATUM, GLVCERIN, PARAFFINUM\nunumum MINERAL OIL. CETEARYL ALCOHOL, DIMETHICONE, Buwnomamtmﬁgﬁ‘\nUUERISHEA BUTTER. BENZYL ALCOHOL. BENZVL SALICVLATE, CAPRYLVGLVCERYL\nc1 15510/0RANGE 4, CI 47005/ACID YELLOW 3, COUMARILP‘JVE W M\nCiNNAMAL, LIMONENE, LINALOOL, OLEA EUROPAEA OIL I 0\n6-100 STEARATE, PENTAERYTHRITVL\nTVLH‘IDROXVHVDROCINNAMATE,\nSODIUM anaome, 31mm ACID, PARFUM/\n~ ammo/1).\n\n \n \n \n   \n\n"),
       Stub::new(79, true, " \n    \n \n \n     \n      \n    \n\n \n \n   \n\nINGREDIENTszA'oLM- a; V\nETHYLHEXYL PALMITATE - BE -~ x\n\nNIUM CHLORIDE ' SIMMONDSIA CH1 ‘   ~ .‘\nROSPERMUM PARK\" BUTTER ' PARFUM ' BONED?“ ALM\n\n- SODIUM BENZOATE - PANTHENOL ~ GUAR HYDROXYPRUWL-\nTRIMONIUM CHLORIDE - PHOSPHOLlPlDS ‘ C\\TR\\C AC“) -\nGLYCINE SOJA OIL ‘ TOCOPHERYL ACETATE - GLYCOLPm\n\n' GLYCINE SOJA STEROLS ' TOCOPHEROL\n\n  \n\n"),
       Stub::new(84, false, "11005140-INGREDIENTS:AOUA/WATER,CE[EARYLALCOHOL\nDISTEAROYLETHYL annoxvmvwomw\nMETHOSULFATE,OCTYLDODECANULJEAMAYS J\nSTARCH / CORN STARCH. NIACINAMIDE r\nTOMPHEROLSACCHARUMOFFIUNARUMRM f\n/SJJGARCANEEXTRACT,MN.PIGH|APUNICIFOUAI '\nACEHOLAFRUITEXTRACT,CAMEL|NASATNAO|L/ f\nCAMELINASATIVASEEDOILCAMELUASlNENSlS :\nEXTRACT/CAMELLIASINENSISLEAFEXTRACT, F\nBENZOICACID,LlNALOOL,CAPRYLYLGLYCOL, ,5\nCADRYUUCAPRICTRIGLVCERIDEEYRUSM I\nEXTRACT /APPLE FRUIT EXTRACT, wmnome J\nHcmnmcgﬁmCIIRUSMEDICALIMONUM ;\nPEEL EXTRACT / LEMON PEEL EXTRACT. j\nPRUNUSARMENIACAKERNELOIL/APRICOT\nxmaommanmmamm ;\nOIL / SUYBEAN OIL, PARFUM I Emacs. ;\n\n(FlL 04391213) /\n\n \n\n"),
       Stub::new(61, true, "      \n   \n   \n        \n    \n      \n\nINGREDIENTS: Butane, Isobutane, Propane,\nAluminum Chlorohydrate, PPG-14 Butyl Ether,\nCyclopentasiloxane, Parfum, Disteardimonium\nHectonte, Helianthus Annuus Seed Oil, C12-15\n§kV‘B?”103te,Octyldodecanol, BHT,\nﬂah'conﬂ. Propylene Carbonate, PEG4.\nEsme, Citric Acid, AI ha-Isomethyl lonone,\n09W. Benzyl alicylate, ButylphenY'\na?p'9na|. CItraI, Geraniol, Hexyl\n'L'm0nene, Linalool.\n\n"),
       Stub::new(74, true, "INGREDIENTS : AQUa (wa‘eﬂ'\nslearate, Propylene glycol, F588\ncapric triglyceride, COCOS can\" ‘Wcla\n(Coconul) oil, Isupropyl palmna‘eW’ 09M\nalcohol, Sorbitan palmitate, pom\n\n40, Parfum (Fragrance), DisodiUm E\nCarbomer. Limonene, cum BHr\nSodium hydroxide, cums glands.\n(Grapefruit) fruit extract, SodiUm\ndroacetate, Sodium methyl dehy‘\n\nSorbic acid, Tetrasodium Elm-A CI\n10316 (Ext Yellow 7)‘\n\n"),
       Stub::new(68, true, "782208 5‘ » INGREDIEMS: AQUA/WATER ~ GLYCERIN ' DIMETHICONE ' ISOHEXADEUNE ' SILICA\n‘ HVDROXVEIHYIHPERAZINE ETHANE SULFONIC ACID ' ALCOHOL DENAT. ' WE SLY“,- '\nSVNTHETIC WAX ' CI 77163 I BISMUTH OXVCHLORIDE ' CI 77391 / TIIANIUM DIOXIDE ' SECALE\nCEREALE EXTRACT/ RYE SEED EXTRACT ' SODIUM ACRYLATES COPOLVMER ‘ SODIUM\nHVALURONATE ‘ PHENOXYETHANOL ‘ ADENDSINE ~ PEG-10 DIMETHICONE ‘ ETHYLHEXYL\nHYDROXVSTEARATE ' NYLON-12 ' DIMETHICONE/PEG-IO/IS CROSSPOLVMER -\nD|HETHICONE/POLVGLYCERIN-3 CROSSPOLYMER ' PENWLENE GLYCOL ‘ SYNTHEIIC\nFLUORPHLOGOPITE ' BENZVL SALICVLATE - BENZVL ALCOHOL ' LINALOOL ‘ BENZVL BENZOATE '\nCAPRVLIUCAPRIC TRIGLYCERIDE ' CAPRVLYL GLYCOI. ‘ DIPOTASSIUM GLVCVRRHIZATE ' ALPINIA\nGAUNGA LEAF EXTRACT ' DISTEARDIMDNIUN HECTDRITE ' DISOUIUM EDTA - CIIRONELLOL ‘\nPARFUH/ FRAGRANCE. (F.I.L 3166675”).\nIorl MermIzIonI su\n\nM399 V ,\nwww.lorealpans.nt\n\n \n\n \n\n"),
       Stub::new(62, true, "Ingredients: Aqua - Cetearyl Alcohol ~ Behentrlmonium Chloride v Glycol Distearate - Dime\nthicone - Distearoylethyl Hydroxyethylmonium Methosulfale ~ Dicaprylyl Carbonate‘ Prunus\nArmeniaca Kernel Oil ~ Amodimethicone/Morphollnomethyl Silsesquioxane Copolymer ‘\nPantheno! ‘ Cocodimonlum Hydroxypropyl Hydrolyzed Keratln - Hydrolyzed Keratln - Glyce\nrln ~ lsopropyl Alcohol - Phenoxyethanol - Methylparaben ‘ Parfum - Polyquaternium-67 -\nLactic Acid ‘ Hexyl Cinnamal - Benzyl Salicylate ~ Limonene ‘ Tridecethﬁ - CI 42053\n\n"),
       Stub::new(76, true, "aqua (water), cyclopentasiloxane, nylon-12, ethylhexyl methoxycinnamate, lauryl PEG-9\npolydimethylsiloxyethyl dimethicone, cyclohexasiloxane, isodecyl neopentanoate, talc,\nbis-ethylhexyloxyphenol methoxyphenyl triazine, PEG-10 dimethicone, pentylene glycol,\ntrimethylsiloxysilicate, aluminum/magnesium hydroxide stearate, HDl/trimethylol hexyllactone\ncrosspolymer, titanium dioxide, silica, ethylhexylglycerin, glyceryl caprylate, sodium chloride,\ntriethoxycaprylylsilane, hydrogen dimethicone, aluminum hydroxide, tocopheryl acetate, moringa\noleifera seed oil, theobroma cacao extract (theobroma cacao (cocoa) extract), glycerin,\ncaprylic/capric triglyceride, pistacia lentiscus gum (pistacia lentiscus (mastic) gum), lecithin,\ntetrasodium EDTA.\n\n"),
       Stub::new(84, true, "lngredienti/lngredients: Aqua/water. butyrospermum parkii butter\nextract/butyrospermum parkii (shea) butter extract. ethylhexyi\npalmitate. eththexyl methoxycinnamate, citrus sinensis sanguinaria\nextract‘/citrus sinensis (blood orange) sanguinaria extract“. octocryle-\nne. hydroxyethyl acrylate/sodium acryloyLdimethyL taurate\ncopolymer, cetearyl isononanoate, ethylhexyL stearate. Isohexadeca-\nne. phenoxyethanol, bisethylhexyLoxyphenol methoxyphenyL triazine.\nammonium acryloyldimethyltaurate/vp copoiymerl ethylhexylglyce—\nrin. parfum/fragrance, sodium dehydroacetate, heLianthus annuus seed\noil/hellanthus annuus (sunflower) seed oiL, Lecithin, sodium hyaLurona-\nte. lactic acid. tocopherol, hydroiyzed hyaluronic acid, sodium lauroyl\nlactylate, ascorbyl palmltate, Lupinus albus seed extract, citric acid,\nceramide 3, phytosphingosine, ceramide 6-ll, xanthan gum. ceramlde I.\n\n"),
       Stub::new(65, false, "INGREDIENT]: Aqua (WBIEVL Eutyrospem'lum Park“ Euﬂer (Shea Elmer), PEG-6\n\nSisarale, Glycol Steamle‘ PEGVSZ Slearale, G‘ycery‘ Slearale, G‘ycenn, Ceteary‘\n\nAlcohol. Xanthan Gum‘ Sodmm PoWacrylate, Dimetmcoml, Par‘um (Fragrance),\n\n O/dopenlagbxane Phermyalhaml, Memylperaben, PW.\nImidazoyldmyl Uvea, BHT‘ Dlsodmm EDTA\n\n"),
       Stub::new(85, true, "N...‘\n\nAqua, Cocamidopropyl Betaine, Sodium;\nLauroyl Sarcosinate**, Sodium Myristoyl Sarcosinate**,‘\nCocoglucoside**, Glyceryl Oleate**, Argania Spinosa'\nKernel Oi|*, Linum Usitatissimum Seed Extract“, PCA**.\nPropanediol**, Guar h droxypropyltrimonium Chloride,\nGlycerin*, Tocopherol, etrasodium Glutamate Diacetate.\nSodium Benzoate, Phenoqethanol, Citric Acid, Parfumz\n\n \n  \n \n  \n\n"),
       Stub::new(70, true, "INGREDIENTS: AQUA ~ SODIUM [AUREIH SULFATE ' (OGMIIID‘\nPROM BETAIHE ' SODIUM [HLDRIDE ‘ GIYEOL DISIEARATE'\nSODIUM BENZOATE ' PEG-‘7 G‘LYIIERYL COCOATE * (ITRII ALIII '\nPANIHEHOI. ' PARFUM ‘ LAURETH-h ' POLYOUATERIIIUM‘III-\nPROPYLENE GIYCGL ' POTASSIUM SORBATE - NIMIIIAMID‘E '\nSTYRENEIACRYLATES CDPOLYMER ’ ETHOXY‘DIGIYCDI ' UREA\nPAMYA FRUIT BITRAU ' BUIYLENE GLYCOI. ' PRUNUS PERSIU\ni, , £5 ‘ MUN A£ID ' FORMIC ACID ' SODIUM LAURYL SUIHIE'\n ACID ' [INMOOI ' [I 15985\n\n"),
       Stub::new(62, false, "Ingredieﬁts Aqua, Cetéargl Alcohol, Steamlkoniur‘n leoride, Behgnol Alconm, Ugcergl\nStearate,Clueterniurn~81Cetrirnonium Methosulrate‘ ﬁ'agrance, Green Tea Extract,\n\nSorljtan Monoleate, Guar Hgdroxgpromltrimonium Chloride, Stearic Acid,\nPEGJSD Penkaergthritgl Tetrastearate, Citric Acid, DMDM Hgdantoin, IPBE‘\n\n"),
       Stub::new(75, true, "694508 13~1NGREDIENTS AQUA/WATER. KAOUN, GLYCERiN, BUTYLENE\nGLYCOL, ZEA MAYS STARCH/CORN STARCH CI 77891 [TITANIUM DIOXIDE,\nDECYL GLUCOS!DE, POLYETHYLENE, éODIUM LAURETH SULFATE,\n\".HONDRUS CRISPUS CARRAGEENAN PEG-7 GLYCERYL COCOATE,\niiALICYLlC ACiD, EUC LYPTUS GLOB LUS EXTRACT/EUCALYPTUS\n: LOBULUS LEAF EXIRACT MENTHOLZINC GLUCOMTE, JOJOBA ESTERS.\n5 3OPYUENE GLYCOL. TRIELD'IANOLAMINE, XANTHAN GUM TETRASODIJM\nE )TA, METHYLPARABEN, PHENOXYEIHANOL, CI 77007/ULTRAMARINES,\n9' \\RFU%€9R&%RANCE, BENZYL SALICYLATE. LIMONENE, LINALOOL\n: .l.L.B2 .\n\n"),
       Stub::new(77, false, "INGREDIENTS -\n\nE .\n. AQUA - AMMONIUM LAURYL SULFAT\nEOCAMIDOPROPYL BETAINE . SALICYLIC ACID - PUNc'g’L‘\nRANATUM EXTRACT - BUTYLENE GLYCOL - DE U_.\nLUCosmE - PIROCTONE OLAMINE - PARFUM - LAG\nGLUCOSle - PANTHENOL - GUAR HYDROXYPR I\nPIMONIUM CHLORIDE - pOLYQUATESth‘éN'mE.\nWQXYETH NOSODIUM HYDROXIDE LIMO\n\n\\L-ETHYLHEXYLGLYCERIN\n\n \n\n"),
       Stub::new(80, true, "1149601 - INGREDIENTS: AQUA / WATER, CETEARYL ALCOHOL,\nDIPALMITOYLETHYL HYDROXYETHYLMONIUM METHOSULFATE, GLYCERYL\nSTEARATE, 0UATERNIUM-80, LIMONENE, LINALOOL, BENZYL SALICYLATE,\nBENZYL ALCOHOL, PROPYLENE GLYCOL, GERANIOL, ROSA CENTIFOLIA EXTRACT/\nROSA CENTIFOLIA FLOWER EXTRACT, CETRIMONIUM CHLORIDE, CITRIC ACID,\n\nCITRONELLOL, LAVANDULA ANGUSTIFOLIA OIL / LAVENDER OIL, GLYCERIN,\nPARFUM / FRAGRANCE (F.l.L. 0159104/2).\n\n")]
    end
  end
end
