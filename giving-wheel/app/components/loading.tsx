export default function Loading() {
    return (
        <div className="inset-0 flex items-center gap-2 max-w-fit">
            <span className="w-[7px] h-[7px] rounded-full bg-neutral-500 text-neutral-500 animation-delay-0 animate-dot-flashing mx-auto"/>
            <span className="w-[7px] h-[7px] rounded-full bg-neutral-500 text-neutral-500 animation-delay-500 animate-dot-flashing mx-auto"/>
            <span className="w-[7px] h-[7px] rounded-full bg-neutral-500 text-neutral-500 animation-delay-1000 animate-dot-flashing mx-auto"/>
        </div>
    );
}