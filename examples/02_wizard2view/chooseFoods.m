classdef chooseFoods < wizardpage
    properties
        checkBoxTags = {'fruits', 'tubers', 'nuts', 'cakes', 'pies'};
    end


    methods
        function obj = chooseFoods(parentWizard)
            obj@wizardpage(parentWizard);

            % Must place all UI elements in the structure obj.graphics handles so that they are
            % deleted when the object is deleted. See the wizardpage abstract class destructor.



            for ii=1:length(obj.checkBoxTags)
                obj.graphicsHandles.(obj.checkBoxTags{ii}) = uicontrol(obj.hPagePanel,'Style','checkbox', ...
                    'Units', 'pixels', ...
                    'Tag', obj.checkBoxTags{ii}, ...
                    'Position', [50,100+(ii*20),60,19] , ...
                    'String', obj.checkBoxTags{ii}, ...
                    'CallBack', @obj.CheckBoxValidate);
                    obj.validAnswersStruct.(obj.checkBoxTags{ii}) = false;
            end

            % If any of the checkboxes are true then we set the following to true


            % By default no next button unless edit box is valid
            obj.hNextButton.Enable = 'off'; 

            % Attempt to re-apply cached data
            obj.reapplyCachedData

        end % chooseFoods

        % TODO -- Some way to allow the result to be valid when at least one checkbox is checked.
        % So we need to do an "any" instead of an "all". But how? wizardPage.checkValidAnswers
        function CheckBoxValidate(obj,src,~)

            if isempty(src.String)
                obj.validAnswersStruct.(src.Tag)=false;
                return
            end

            %Store these in the cachedData
            obj.cacheVals(src)

            % By default the data in a wizardpage are considered valid if all are set to be valid.
            % In this case we consider a valid response to be at least one checkbox ticked. So we
            % check for this and if so we set everything to be true
            if  any(structfun(@(x) x.Value, obj.graphicsHandles,'UniformOutput',true))
                % At least one is true
                for ii=1:length(obj.checkBoxTags)
                    obj.validAnswersStruct.(obj.checkBoxTags{ii}) = true;
                end
            else
                % None are true
                for ii=1:length(obj.checkBoxTags)
                    obj.validAnswersStruct.(obj.checkBoxTags{ii}) = false;
                end
            end
 
        end %validateColorBox


    end %methods

end %classdef