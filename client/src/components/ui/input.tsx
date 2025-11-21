import * as React from "react";

export interface InputProps
  extends React.InputHTMLAttributes<HTMLInputElement> {
  leftIcon?: React.ReactNode;
  rightElement?: React.ReactNode;
}

const Input = React.forwardRef<HTMLInputElement, InputProps>(
  ({ className, type, leftIcon, rightElement, ...props }, ref) => {
    return (
      <div className="relative flex w-full items-center">
        {leftIcon && (
          <div className="absolute left-4 flex items-center justify-center text-slate-500 dark:text-[#93a5c8]">
            {leftIcon}
          </div>
        )}
        <input
          type={type}
          className={`
            flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-lg 
            text-slate-800 dark:text-white 
            focus:outline-none focus:ring-2 focus:ring-primary/50 
            border border-slate-300 dark:border-[#344465] 
            bg-white dark:bg-[#1a2232] 
            focus:border-primary dark:focus:border-primary 
            h-14 
            placeholder:text-slate-400 dark:placeholder:text-[#93a5c8] 
            p-[15px] text-base font-normal leading-normal
            ${leftIcon ? "pl-12" : ""}
            ${rightElement ? "pr-12" : "pr-4"}
            ${className}
          `}
          ref={ref}
          {...props}
        />
        {rightElement && (
          <div className="absolute right-0 h-full px-4 flex items-center justify-center text-slate-500 dark:text-[#93a5c8]">
            {rightElement}
          </div>
        )}
      </div>
    );
  }
);
Input.displayName = "Input";

export { Input };

