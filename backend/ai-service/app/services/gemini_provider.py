from google import genai
from google.genai import types
import re
from ..core.config import settings
from .llm_provider import LLMProvider

class GeminiProvider(LLMProvider):
    def __init__(self):
        self.client = genai.Client(api_key=settings.GEMINI_API_KEY)
        self.model = settings.GEMINI_MODEL

    async def generate_content(self, prompt: str, **kwargs) -> str:
        try:
            # Check if JSON response mode is requested
            response_mime_type = kwargs.get('response_mime_type')
            
            # Build generation config from kwargs
            config_params = {
                "max_output_tokens": kwargs.get('max_output_tokens'),
                "temperature": kwargs.get('temperature'),
                "top_p": kwargs.get('top_p'),
                "top_k": kwargs.get('top_k'),
            }
            
            # Add response_mime_type if specified (forces JSON output)
            if response_mime_type:
                config_params["response_mime_type"] = response_mime_type
            
            config = types.GenerateContentConfig(**{k: v for k, v in config_params.items() if v is not None})
            
            response = self.client.models.generate_content(
                model=self.model,
                contents=prompt,
                config=config
            )
            return self._clean_response(response.text)
        except Exception as e:
            # Handle API errors gracefully
            raise Exception(f"Gemini API Error: {str(e)}")

    def _clean_response(self, text: str) -> str:
        # Extract content from markdown code blocks if present
        # First try to match complete code blocks
        pattern = r"```(?:json)?\s*(.*?)\s*```"
        match = re.search(pattern, text, re.DOTALL | re.IGNORECASE)
        if match:
            text = match.group(1)
        else:
            # Handle unclosed code blocks (response may have been truncated)
            # Try to extract content after opening ```json
            unclosed_pattern = r"```(?:json)?\s*(.*)"
            unclosed_match = re.search(unclosed_pattern, text, re.DOTALL | re.IGNORECASE)
            if unclosed_match:
                text = unclosed_match.group(1)
        
        # Strip leading/trailing whitespace
        return text.strip()

    def get_provider_name(self) -> str:
        return "gemini"

