classdef chooseColor < wizardpage
    properties
        fSize = 10
    end


    methods
        function obj = chooseColor(parentWizard)
            obj@wizardpage(parentWizard);

            % Must place all UI elements in the structure obj.graphics handles so that they are
            % deleted when the object is deleted. See the wizardpage abstract class destructor.
            obj.graphicsHandles.textBox = annotation(obj.hPagePanel, 'textbox', ...
            'Units', 'pixels', ...
            'Position', [50,300,250,19] , ...
            'EdgeColor', 'none', ...
            'VerticalAlignment', 'middle',...
            'FontSize', obj.fSize, ...
            'FitBoxToText','off', ...
            'String', 'Enter a color string (e.g. r, k, w, etc):');

            editBoxTag = 'colorEditBox';
            obj.graphicsHandles.editBox = uicontrol(obj.hPagePanel,'Style','edit', ...
            'Units', 'pixels', ...
            'Tag', editBoxTag, ...
            'Position', [290,300,30,19] , ...
            'FontSize', obj.fSize, ...
            'String', '', ...
            'CallBack', @obj.validateColorBox);


            % Note that structure field has the same name as the tag. See how this is 
            % is used in the callback function "validateColorBox", below.
            obj.validAnswersStruct.(editBoxTag)=false;

            % By default no next button unless edit box is valid
            obj.hNextButton.Enable = 'off'; 

            obj.reapplyCachedData
        end

        function validateColorBox(obj,src,~)
            % Ensure this is a valid MATLAB color character for a plot command
            src.String = lower(src.String);
            % Removes single quotes
            src.String = strrep(src.String,'''','');

            obj.validAnswersStruct.(src.Tag) = false;
            if length(src.String)>1
                src.String='';
                obj.validAnswersStruct.(src.Tag) = false;
                return
            end

            if isempty( strfind('bgrcmykw',src.String) )
                src.String='';
                obj.validAnswersStruct.(src.Tag) = false;
                return
            end

            chosenColor = src.String;
            obj.mainWizardGUI.output{1} = {'Color',chosenColor};

            %Store these in the cachedData
            obj.cacheVals(src)
        end %validateColorBox


    end %methods

end %classdef
