from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    app_name: str = "PMWeb Automation Agent"
    debug: bool = True

    openai_api_key: str = ""
    openai_model: str = "gpt-4o"

    pmweb_base_url: str = ""
    pmweb_username: str = ""
    pmweb_password: str = ""
    pmweb_headless: bool = False

    cors_origins: list[str] = ["*"]

    model_config = {"env_file": ".env", "env_file_encoding": "utf-8"}


settings = Settings()
