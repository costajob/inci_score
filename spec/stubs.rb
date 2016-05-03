require 'yaml'

module Stubs
  module Levenshtein
    extend self

    Stub = Struct::new(:s, :t, :distance)

    def records
      [Stub::new('', '', 0),
       Stub::new('elvis', 'elvis', 0),
       Stub::new('elvis', 'ELVIS', 0),
       Stub::new('elvis', 'elviz', 1),
       Stub::new('king', 'the king', 4),
       Stub::new('graceland', 'disneyland', 5)]
    end

    def records_multiple
      [Stub::new("föo", 'foo', 1),
       Stub::new("français", "francais", 1),
       Stub::new("français", "franæais", 1),
       Stub::new("私の名前はポールです", "ぼくの名前はポールです", 2)]
    end

    def records_special
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

    Stub = Struct::new(:src, :size)

    def sources
      [Stub::new("Ingredients: Aqua, Disodium Laureth Sulfosuccinate, Cocamidopropiyl\nBetaine, Disodium Cocoamphodiacetate, Giyceryi Laurate, PEGJ\nGlyceryi Cocoate, Sodium Lactate, Parfum,\n\nNiacinamide, Glycine, Magnesium Aspanate,\n\nAianine, Lysine, Leucine,A||antoin, PEG-150 E‘—\n\nDistearate, PEG-120 Methyl Glucose Dioleate, ——\n\nPhenoxyethanoi, CI 61570. 50\n\n \n\n", 20),
       Stub::new("\n\nDIENTS: Aqua, Sodium Laureth Sulfate, Sodium Chlor .\ngﬂfamine, Selaginella Lepidophylla Aerial Extract,PruI|:1es'§:::m\n0.11050“, Irehalose, Gluconolaaone, Glycenn, Guar Hydmyp«mylmmwmu:n\n(hloride, Dimethiconol, Parfum, TEA-Dodetylbenzenesulfonate, 015mm\nEDIA, Mica, (arbomer, PPS-12, (itric Acid, Sodium HydmxideJEMuHate,\n\nWnethanolamine, Sodium Benzoate, DMDM Hydantoin, Methykhlowiso-\nIhmzoh'none, Methylisothiazolinone, ButylphenyI Methylpmpionaumm\n(142051, (I 47005, (I 77891.\n\n", 28),
       Stub::new("1099488 B - INGREDIENTS : AOUA I WATER.\nSODIUM LAURETH SULFATE, COCO-BETAINE,\nSODIUM LAURYL SULFATE. SODIUM CHLORIDE.\nGLYCOL DISTEARATE, NIACINAMIDE,_ ALCOHOL\nDEI‘IAT., SACCHARUM OFFICINARUM’EXTRACT I\nSUGAR CANE EXTRACT, HYDROXYPROPXLGUAR\nHYDROXVPROPYLTRIMONIUM CHLORIDE. SODIUM\nHYDROXIDE, AMINOPROPYL TRIETHOXYSILANE,\nPOLYOUATERNIUM-SO. CAMELLIA SINENGIS\nLEAF EXTRACT, BENZYL ALCOHOL, LINALOOL,\nPUNICA GRANATUM EXTRACT, 2—OLEAMIDO-1,3-\nOCTADECANEDIOL, ACRYLATES COPOLYMER, PYRUS\nMALUS EXTRACT / APPLE FRUIT EXTRACT, PYRIDOXINE\nHCI. CITRIC ACID, METHYLCHLOROISOTHIAZOUNONE.\nMETHYLISOTHIAZOUNONE, CITRUS MEDICA UMONUM\nPEEL EXTRACT/ LEMON PEEL EXTRACT. HEXYLENE\n\nGLYCOL, HEXYL CINNAMAL, AMYL CINNAMAL.\n\nPARFUM / FRAGRANCE (FIL C1631 07/2).\n\n", 30),
       Stub::new("7023 10 - INGREDIENTS: CAPRYLIC/CAPRIC\nﬁlGLYCERIDE, ISOPROPYL PALMITATE, ISOPROPYL\nMYRISTATE, PARFUM / FRAGRANCE, BENZYL ALCOHOL.\nBENZY L SALICYLATE, COUMARIN. HEXYL CINNAMAL,\nLIMONENE, LINALOOL, OLEA\n\nEUROPAEA 0|L/ OLIVE FRUIT\nOIL, PENTAERYTHRITYL\nTETRA-DI-T-BUTYL\nHYDROXYHYDROCINNAMAIE.\n«11317540710.\n\n", 13),
       Stub::new("mom-mansmsms: AQUA/WATER, PETROLATUM, GLVCERIN, PARAFFINUM\nunumum MINERAL OIL. CETEARYL ALCOHOL, DIMETHICONE, Buwnomamtmﬁgﬁ‘\nUUERISHEA BUTTER. BENZYL ALCOHOL. BENZVL SALICVLATE, CAPRYLVGLVCERYL\nc1 15510/0RANGE 4, CI 47005/ACID YELLOW 3, COUMARILP‘JVE W M\nCiNNAMAL, LIMONENE, LINALOOL, OLEA EUROPAEA OIL I 0\n6-100 STEARATE, PENTAERYTHRITVL\nTVLH‘IDROXVHVDROCINNAMATE,\nSODIUM anaome, 31mm ACID, PARFUM/\n~ ammo/1).\n\n \n \n \n   \n\n", 19),
       Stub::new(" \n    \n \n \n     \n      \n    \n\n \n \n   \n\nINGREDIENTszA'oLM- a; V\nETHYLHEXYL PALMITATE - BE -~ x\n\nNIUM CHLORIDE ' SIMMONDSIA CH1 ‘   ~ .‘\nROSPERMUM PARK\" BUTTER ' PARFUM ' BONED?“ ALM\n\n- SODIUM BENZOATE - PANTHENOL ~ GUAR HYDROXYPRUWL-\nTRIMONIUM CHLORIDE - PHOSPHOLlPlDS ‘ C\\TR\\C AC“) -\nGLYCINE SOJA OIL ‘ TOCOPHERYL ACETATE - GLYCOLPm\n\n' GLYCINE SOJA STEROLS ' TOCOPHEROL\n\n  \n\n", 10),
       Stub::new("11005140-INGREDIENTS:AOUA/WATER,CE[EARYLALCOHOL\nDISTEAROYLETHYL annoxvmvwomw\nMETHOSULFATE,OCTYLDODECANULJEAMAYS J\nSTARCH / CORN STARCH. NIACINAMIDE r\nTOMPHEROLSACCHARUMOFFIUNARUMRM f\n/SJJGARCANEEXTRACT,MN.PIGH|APUNICIFOUAI '\nACEHOLAFRUITEXTRACT,CAMEL|NASATNAO|L/ f\nCAMELINASATIVASEEDOILCAMELUASlNENSlS :\nEXTRACT/CAMELLIASINENSISLEAFEXTRACT, F\nBENZOICACID,LlNALOOL,CAPRYLYLGLYCOL, ,5\nCADRYUUCAPRICTRIGLVCERIDEEYRUSM I\nEXTRACT /APPLE FRUIT EXTRACT, wmnome J\nHcmnmcgﬁmCIIRUSMEDICALIMONUM ;\nPEEL EXTRACT / LEMON PEEL EXTRACT. j\nPRUNUSARMENIACAKERNELOIL/APRICOT\nxmaommanmmamm ;\nOIL / SUYBEAN OIL, PARFUM I Emacs. ;\n\n(FlL 04391213) /\n\n \n\n", 17),
       Stub::new("      \n   \n   \n        \n    \n      \n\nINGREDIENTS: Butane, Isobutane, Propane,\nAluminum Chlorohydrate, PPG-14 Butyl Ether,\nCyclopentasiloxane, Parfum, Disteardimonium\nHectonte, Helianthus Annuus Seed Oil, C12-15\n§kV‘B?”103te,Octyldodecanol, BHT,\nﬂah'conﬂ. Propylene Carbonate, PEG4.\nEsme, Citric Acid, AI ha-Isomethyl lonone,\n09W. Benzyl alicylate, ButylphenY'\na?p'9na|. CItraI, Geraniol, Hexyl\n'L'm0nene, Linalool.\n\n", 25),
       Stub::new("INGREDIENTS : AQUa (wa‘eﬂ'\nslearate, Propylene glycol, F588\ncapric triglyceride, COCOS can\" ‘Wcla\n(Coconul) oil, Isupropyl palmna‘eW’ 09M\nalcohol, Sorbitan palmitate, pom\n\n40, Parfum (Fragrance), DisodiUm E\nCarbomer. Limonene, cum BHr\nSodium hydroxide, cums glands.\n(Grapefruit) fruit extract, SodiUm\ndroacetate, Sodium methyl dehy‘\n\nSorbic acid, Tetrasodium Elm-A CI\n10316 (Ext Yellow 7)‘\n\n", 16),
       Stub::new("782208 5‘ » INGREDIEMS: AQUA/WATER ~ GLYCERIN ' DIMETHICONE ' ISOHEXADEUNE ' SILICA\n‘ HVDROXVEIHYIHPERAZINE ETHANE SULFONIC ACID ' ALCOHOL DENAT. ' WE SLY“,- '\nSVNTHETIC WAX ' CI 77163 I BISMUTH OXVCHLORIDE ' CI 77391 / TIIANIUM DIOXIDE ' SECALE\nCEREALE EXTRACT/ RYE SEED EXTRACT ' SODIUM ACRYLATES COPOLVMER ‘ SODIUM\nHVALURONATE ‘ PHENOXYETHANOL ‘ ADENDSINE ~ PEG-10 DIMETHICONE ‘ ETHYLHEXYL\nHYDROXVSTEARATE ' NYLON-12 ' DIMETHICONE/PEG-IO/IS CROSSPOLVMER -\nD|HETHICONE/POLVGLYCERIN-3 CROSSPOLYMER ' PENWLENE GLYCOL ‘ SYNTHEIIC\nFLUORPHLOGOPITE ' BENZVL SALICVLATE - BENZVL ALCOHOL ' LINALOOL ‘ BENZVL BENZOATE '\nCAPRVLIUCAPRIC TRIGLYCERIDE ' CAPRVLYL GLYCOI. ‘ DIPOTASSIUM GLVCVRRHIZATE ' ALPINIA\nGAUNGA LEAF EXTRACT ' DISTEARDIMDNIUN HECTDRITE ' DISOUIUM EDTA - CIIRONELLOL ‘\nPARFUH/ FRAGRANCE. (F.I.L 3166675”).\nIorl MermIzIonI su\n\nM399 V ,\nwww.lorealpans.nt\n\n \n\n \n\n", 30)]
    end
  end

  module Computer
    extend self

    def ingredients
      ["aqua", "disodium laureth sulfosuccinate", "cocamidopropiyl betaine", "disodium cocoamphodiacetate", "giyceryi laurate", "pegj glyceryi cocoate", "sodium lactate", "parfum", "niacinamide", "glycine", "magnesium aspanate", "aianine", "lysine", "leucine", "allantoin", "peg150 e distearate", "peg120 methyl glucose dioleate", "phenoxyethanoi", "ci 61570", "50"]
    end

    def catalog
      {"alanine"=>0, "allantoin"=>0, "aqua"=>0, "ci 61570"=>3, "cocamidopropyl betaine"=>1, "disodium cocoamphodiacetate"=>0, "disodium laureth sulfosuccinate"=>2, "glyceryl laurate"=>0, "glycine"=>0, "leucine"=>0, "lysine"=>0, "magnesium aspartate"=>0, "niacinamide"=>0, "peg-120 methyl glucose dioleate"=>3, "peg-150 distearate"=>3, "peg-7 glyceryl cocoate"=>3, "phenoxyethanol"=>2, "sodium lactate"=>0}
    end

    def instance
      @instance ||= InciScore::Computer::new(catalog: catalog, normalizer: -> { ingredients } )
    end
  end
end
