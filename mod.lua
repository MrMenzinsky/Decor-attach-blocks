local mod = foundation.createMod();

-- To easily read in and correctly parse the different attach points (Attach_Bottom, Attach_Top etc.)
mod:registerAssetProcessor("models/Scalable_Attach_Cube.fbx", {
    DataType = "BUILDING_ASSET_PROCESSOR"
})

-- Single scaling build part (root, tiling, top)
mod:registerAssetId("models/Scalable_Attach_Cube.fbx/Prefab/Root_Part", "PREFAB_ROOT_PART")
mod:registerAssetId("models/Scalable_Attach_Cube.fbx/Prefab/Tiling_Part", "PREFAB_TILING_PART")
mod:registerAssetId("models/Scalable_Attach_Cube.fbx/Prefab/Top_Part", "PREFAB_TOP_PART")

-- mod:registerPrefabComponent("models/Scalable_Attach_Cube.fbx/Prefab/Root_Part/Attach_Major", {
--     DataType = "COMP_BUILDING_ATTACH_NODE",
--     AttachNodeTypeList = {"MAJOR"},
--     MultipleOrientationCount = 4
-- })

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
    }
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
            DataType = "GAME_CONDITION_BUILDING_BUILT",
            AssetBuilding = "BUILDING_VILLAGE_CENTRE"
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
