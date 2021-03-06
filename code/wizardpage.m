classdef wizardpage < handle
%% wizardpage
%
% The wizardpage superclass is to be inherited by all wizard pages
%
    properties
  

    end % properties

    properties (SetObservable)
        graphicsHandles
        validAnswersStruct % A structure of bools indicating which page elements are valid and which invalid.
        isValid = false % Set to true when the form is valid. This is set automatically based on validAnswerStruct
    end

    properties (Hidden)
      % The following are just convenience references or copes of elements in the main wizard
        hNextButton
        hPreviousButton
        hPagePanel
        currentPage

        mainWizardGUI % Finally a reference to the wizard page itself that includes the above

        listeners = {}
    end


    methods

        function obj = wizardpage(mainWizardGUI)
            if nargin<1
                return
            end 
            if ~isa(mainWizardGUI,'wizard')
                return
            end 
            
            % Make local references
            obj.hNextButton = mainWizardGUI.hNextButton;
            obj.hPreviousButton = mainWizardGUI.hPreviousButton;
            obj.hPagePanel = mainWizardGUI.hPagePanel;
            obj.currentPage = mainWizardGUI.currentPage;
            obj.mainWizardGUI = mainWizardGUI;
            
            obj.listeners{end+1} = addlistener(obj, 'validAnswersStruct', 'PostSet', @obj.checkValidAnswers);
            obj.listeners{end+1} = addlistener(obj, 'isValid', 'PostSet', @obj.updateNextButtonWhenValid);    
        end % wizardpage constructor


        function delete(obj)
            % This is the "destructor". It runs when an instance of the class comes to an end.
            cellfun(@delete,obj.listeners)

            if ~isempty(obj.graphicsHandles) && isstruct(obj.graphicsHandles)
                f=fields(obj.graphicsHandles);
                for ii=1:length(f)
                    delete(obj.graphicsHandles.(f{ii}))
                end
            end
        end % delete


        function checkValidAnswers(obj,~,~)
            % Sets obj.isValid to true if all booleans in validAnswersStruct are true
            if isempty(obj.validAnswersStruct)
                obj.isValid = false;
                return
            end

            if islogical(obj.validAnswersStruct)
                obj.isValid = obj.validAnswersStruct;
                return
            end

            if isstruct(obj.validAnswersStruct)
                tFields = fields(obj.validAnswersStruct);
                tBools = zeros(1,length(tFields),'logical');
                for ii=1:length(tFields)
                    tBools(ii) = obj.validAnswersStruct.(tFields{ii});
                end

                obj.isValid = all(tBools == true);
            end

        end %checkValidAnswers


        function updateNextButtonWhenValid(obj,~,~)
            if obj.isValid == true
                obj.hNextButton.Enable = 'on';
            else 
                obj.hNextButton.Enable = 'off';
            end
                
        end %updateNextButtonWhenValid


        function reapplyCachedData(obj)
            % Must be run when the wizardpage is constructed
            if length(obj.mainWizardGUI.cachedData)<obj.currentPage
                return
            end 

            if isempty(obj.mainWizardGUI.cachedData{obj.currentPage})
                return
            end
               

            cachedData = obj.mainWizardGUI.cachedData{obj.currentPage};
            tFields = fields(cachedData);
            for ii = 1:length(tFields)
                tagName = tFields{ii};
                cData = cachedData.(tagName);
                UI = findobj(obj.mainWizardGUI.hFig,'Tag',tagName);
                UI.(cData.UIprop) = cData.value;
                obj.validAnswersStruct.(tagName) = true; %If it was stored it must be valid
            end
        end %reapplyCachedData


        function cacheVals(obj,src,~)
            % wizardpage.cacheVals
            % 
            % Behavior
            % This is a callback function that caches values for re-use should the user go
            % back and forth through a wizard. This method may, of course, be run as a conventional
            % method instead of a callback. In this case the user must explicitly supply the 
            % UI element to cachce as an input argument.
            % 
            % This method has only been tested against the following UI elements made using "uicontrol":
            % - edit boxes
            % - popup menus
            %
            % 
            %
            % Inputs
            % src  - The UI element to cache. 


            % Cache values based on what the UI element was
            if isa(src,'matlab.ui.control.UIControl')
                switch src.Style
                case 'edit'
                    obj.mainWizardGUI.cachedData{obj.currentPage}.(src.Tag).UIprop = 'String';
                    obj.mainWizardGUI.cachedData{obj.currentPage}.(src.Tag).value = src.String;
                case {'popupmenu','checkbox'}
                    obj.mainWizardGUI.cachedData{obj.currentPage}.(src.Tag).UIprop = 'Value';
                    obj.mainWizardGUI.cachedData{obj.currentPage}.(src.Tag).value = src.Value;
                    obj.mainWizardGUI.cachedData{obj.currentPage}.(src.Tag).String = src.String;
                end
            end

            % Since we cached it, it must be a valid value so we full in the bool
            obj.validAnswersStruct.(src.Tag)=true;

        end % cacheVals

    end % methods

end % classdef
