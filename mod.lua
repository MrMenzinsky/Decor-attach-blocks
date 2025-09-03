local mod = foundation.createMod();

-- To easily read in and correctly parse the different attach points (Attach_Bottom, Attach_Top etc.)
mod:registerAssetProcessor("models/Scalable_Attach_Cube.fbx", {
    DataType = "BUILDING_ASSET_PROCESSOR"
})

-- Single scaling build part (root, tiling, top)
mod:registerAssetId("models/Scalable_Attach_Cube.fbx/Prefab/Root_Part", "PREFAB_ROOT_PART")
mod:registerAssetId("models/Scalable_Attach_Cube.fbx/Prefab/Tiling_Part", "PREFAB_TILING_PART")
mod:registerAssetId("models/Scalable_Attach_Cube.fbx/Prefab/Top_Part", "PREFAB_TOP_PART")

-- Make so the Attach_Major snapping node can snap at all four 90 degree angles and isn't forced to its original orientation
mod:registerPrefabComponent("models/Scalable_Attach_Cube.fbx/Prefab/Root_Part/Attach_Major", {
    DataType = "COMP_BUILDING_ATTACH_NODE",
    MultipleOrientationCount = 4
})

-- Register custom number swatches
mod:registerAssetId("icons/Icon_Button_Swatch_1.png", "ICON_BUTTON_RECOLOR_SWATCH_1", "ATLAS_CELL")
mod:registerAssetId("icons/Icon_Button_Swatch_2.png", "ICON_BUTTON_RECOLOR_SWATCH_2", "ATLAS_CELL")
mod:registerAssetId("icons/Icon_Button_Swatch_3.png", "ICON_BUTTON_RECOLOR_SWATCH_3", "ATLAS_CELL")
mod:registerAssetId("icons/Icon_Button_Swatch_4.png", "ICON_BUTTON_RECOLOR_SWATCH_4", "ATLAS_CELL")
mod:registerAssetId("icons/Icon_Button_Swatch_5.png", "ICON_BUTTON_RECOLOR_SWATCH_5", "ATLAS_CELL")
mod:registerAssetId("icons/Icon_Button_Swatch_6.png", "ICON_BUTTON_RECOLOR_SWATCH_6", "ATLAS_CELL")
mod:registerAssetId("icons/Icon_Button_Swatch_7.png", "ICON_BUTTON_RECOLOR_SWATCH_7", "ATLAS_CELL")
mod:registerAssetId("icons/Icon_Button_Swatch_8.png", "ICON_BUTTON_RECOLOR_SWATCH_8", "ATLAS_CELL")

-- Register material textures
mod:registerAssetId("models/Scalable_Attach_Cube.fbx/Materials/Mat_Wall_Stone_Rustic_01A_Diff.png", "WALL_STONE_RUSTIC")
mod:registerAssetId("models/Scalable_Attach_Cube.fbx/Materials/Mat_Wall_Stone_Rustic_Moss_Diff.png", "WALL_STONE_RUSTIC_MOSS")
mod:registerAssetId("models/Scalable_Attach_Cube.fbx/Materials/Mat_Castle_Modest_Wall_Stone_01A_Diff.png", "CASTLE_MODEST_WALL_STONE")
mod:registerAssetId("models/Scalable_Attach_Cube.fbx/Materials/Mat_Castle_Modest_Wall_Stone_Moss_01A_Diff.png", "CASTLE_MODEST_WALL_STONE_MOSS")
mod:registerAssetId("models/Scalable_Attach_Cube.fbx/Materials/Mat_Gen_Wall_Plaster_01A_Diff.png", "WALL_PLASTER")
mod:registerAssetId("models/Scalable_Attach_Cube.fbx/Materials/Mat_Gen_Wall_LimeBrick_Plaster_01A_Diff.png", "WALL_LIMEBRICK_PLASTER")
mod:registerAssetId("models/Scalable_Attach_Cube.fbx/Materials/Mat_Gen_Wall_Stucco_02A_Diff.png", "WALL_STUCCO")
mod:registerAssetId("models/Scalable_Attach_Cube.fbx/Materials/Mat_Gen_Wall_WoodPLanks_01A_Diff.png", "WALL_WOODPLANKS")

-- Register custom swatches for recoloring/changing the texture on the block
mod:registerAsset({
	DataType = "MATERIAL_SET_LIST",
	Id = "BLOCK_MATERIAL_SET_LIST",
	MaterialSetList = {
        {
            SetName = "WALL_STONE_RUSTIC",
            AssetSelectionButtonImage = "ICON_BUTTON_RECOLOR_SWATCH_1",
            MaterialList = {
                "WALL_STONE_RUSTIC"
            }
        },
        {
            SetName = "WALL_STONE_RUSTIC_MOSS",
            AssetSelectionButtonImage = "ICON_BUTTON_RECOLOR_SWATCH_2",
            MaterialList = {
                "WALL_STONE_RUSTIC_MOSS"
            }
        },
        {
            SetName = "CASTLE_MODEST_WALL_STONE",
            AssetSelectionButtonImage = "ICON_BUTTON_RECOLOR_SWATCH_3",
            MaterialList = {
                "CASTLE_MODEST_WALL_STONE"
            }
        },
        {
            SetName = "CASTLE_MODEST_WALL_STONE_MOSS",
            AssetSelectionButtonImage = "ICON_BUTTON_RECOLOR_SWATCH_4",
            MaterialList = {
                "CASTLE_MODEST_WALL_STONE_MOSS"
            }
        },
        {
            SetName = "WALL_PLASTER",
            AssetSelectionButtonImage = "ICON_BUTTON_RECOLOR_SWATCH_5",
            MaterialList = {
                "WALL_PLASTER"
            }
        },
        {
            SetName = "WALL_LIMEBRICK_PLASTER",
            AssetSelectionButtonImage = "ICON_BUTTON_RECOLOR_SWATCH_6",
            MaterialList = {
                "WALL_LIMEBRICK_PLASTER"
            }
        },
        {
            SetName = "WALL_STUCCO",
            AssetSelectionButtonImage = "ICON_BUTTON_RECOLOR_SWATCH_7",
            MaterialList = {
                "WALL_STUCCO"
            }
        },
        {
            SetName = "WALL_WOODPLANKS",
            AssetSelectionButtonImage = "ICON_BUTTON_RECOLOR_SWATCH_8",
            MaterialList = {
                "WALL_WOODPLANKS"
            }
        }
    }
})

mod:registerAsset({
    DataType = "BUILDING",
    Id = "BLOCK",
    Name = "BLOCK_NAME",
    Description = "BLOCK_DESC",
    BuildingType = "DECORATION",
    AssetCoreBuildingPart = "BLOCK_PART"
})

-- Scaling cube parts

-- Root (main) part
mod:registerAsset({
    DataType = "BUILDING_PART",
    Id = "BLOCK_PART",
    Category = "DECORATION",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_SCALER",
        CoreObjectPrefab = "PREFAB_ROOT_PART",
        EndPart = "BLOCK_TOP_PART",
        FillerList = {
            "BLOCK_TILING_PART"
        }
    },
    BuildingZone = {
        ZoneEntryList = {
            {  -- Make the smallest possible collision box so it gets included when double-clicking on adjacent parts
                Polygon = polygon.createRectangle({DataType = "vec2f", 0.01, 0.01}),
                Type = {
                    DEFAULT = true,
                    NAVIGABLE_PART = true
                }
            }
        }
    },
    AssetMaterialSetList = "BLOCK_MATERIAL_SET_LIST"
})

-- Tiling part
mod:registerAsset({
    DataType = "BUILDING_PART",
    Id = "BLOCK_TILING_PART",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_TILING_PART"
    }
})

-- End part
mod:registerAsset({
    DataType = "BUILDING_PART",
    Id = "BLOCK_TOP_PART",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_TOP_PART"
    }
})


-- Create an event asset
mod:registerAsset({
    DataType = "EVENT",
    Id = "EVENT_BLOCK_UNLOCK",
    DaysToFirst = 1,
    ConditionList = {
        {
            DataType = "GAME_CONDITION_BUILDING_AVAILABLE",
            AssetBuilding = "BUILDING_DECORATIVE_ROSE_BUSH"
        }
    },
    ActionList = {
        {
            DataType = "GAME_ACTION_UNLOCK_BUILDING_LIST",
            BuildingProgressData = {
                AssetBuildingList = {
                    "BLOCK"
                }
            }
        }
    }
})

-- Register the event
mod:overrideAsset({
    Id = "DEFAULT_BALANCING",
    EventList = {
        Action = "APPEND",
        "EVENT_BLOCK_UNLOCK"
    }
})
