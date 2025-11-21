import * as React from "react";

export interface LabelProps
  extends React.LabelHTMLAttributes<HTMLLabelElement> {}

const Label = React.forwardRef<HTMLLabelElement, LabelProps>(
  ({ className, ...props }, ref) => {
    return (
      <label
        ref={ref}
        className={`
          text-slate-800 dark:text-white text-base font-medium leading-normal pb-2 block
          ${className}
        `}
        {...props}
      />
    );
  }
);
Label.displayName = "Label";

export { Label };


