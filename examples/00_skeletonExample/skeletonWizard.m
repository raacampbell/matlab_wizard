classdef skeletonWizard < wizard
    % skeletonWizard
    % 
    % Minimal example. Does nothing much. 
    %
    % Instructions:
    % - Run "skeletonWizard;" at the command line
    % - Enter anything into the box;
    % - Press "Done"
    % - Entered string will be in variable "wizardoutput" in base workspace

    properties
    end

    methods

        function obj = skeletonWizard
            % Constructor. Runs once on instantiation.
            obj.pageConstructors = {@skeletonPage};
            obj.renderPage(1)
        end

        function delete(obj)
            obj.output = obj.cachedData{1}.myEditBox.value; %myEditBox defined in skeletonPage
        end

    end % methods

end % classdef
