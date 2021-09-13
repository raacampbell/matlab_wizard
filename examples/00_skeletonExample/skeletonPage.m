classdef skeletonPage < wizardpage

    properties
    end


    methods
        function obj = skeletonPage(parentWizard)
            obj@wizardpage(parentWizard);

            % Must place all UI elements in the structure obj.graphics handles so that they are
            % deleted when the object is deleted. See the wizardpage abstract class destructor.
            obj.graphicsHandles.editBox = uicontrol(obj.hPagePanel,'Style','edit', ...
            'Units', 'pixels', ...
            'Tag', 'myEditBox', ...
            'Position', [100,100,100,50] , ...
            'FontSize', 20, ...
            'String', '', ...
            'CallBack', @obj.validateEditBox);


            % Note that structure field has the same name as the tag. See how this is 
            % is used in the callback function "validateColorBox", below.
            obj.validAnswersStruct.myEditBox=false;

            % By default no next button unless edit box is valid
            obj.hNextButton.Enable = 'off'; 

        end

        function validateEditBox(obj,src,~)
            % Ensure there is something in the edit box.
            if isempty(src.String)
                obj.validAnswersStruct.(src.Tag) = false;
                return
            end

            %Store these in the cachedData even though there is only one page
            obj.cacheVals(src)
        end %validateColorBox


    end %methods

end %classdef
