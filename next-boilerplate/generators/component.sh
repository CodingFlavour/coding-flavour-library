COMPONENT_FILENAME=$(basename "$SELECTED_USERNAME")
COMPONENT_PATH=$SELECTED_USERNAME/$COMPONENT_FILENAME.tsx
COMPONENT_BOILERPLATE=$(<$SCRIPTPATH/templates/component/component.tsx)
COMPONENT_CODE=${COMPONENT_BOILERPLATE//REPLACE/$SELECTED_USERNAME}