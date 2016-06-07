require 'yaml'

PATH_TO_FIXTURES ||= 'fixtures/'
PATH_TO_AGENTS ||= PATH_TO_FIXTURES + 'agents/agents.yml'
AGENT_1 ||= 'agent_1'

class Fixtures
    def agent_1
        self.agents[AGENT_1]
    end

    def agents
        @_agents ||= load_yaml(PATH_TO_AGENTS)
    end

    def load_yaml(relative_path)
        YAML.load_file(File.join(__dir__, relative_path))
    end
end
